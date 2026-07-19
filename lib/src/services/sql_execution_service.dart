import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/shared/models/table_info_model.dart';

/// Executes raw SQL statements against a named SQLite database and
/// inspects its structure.
class SqlExecutionService {
  final _logger = Logger();

  /// Runs one or more semicolon-separated [sql] statements against
  /// [databaseName], returning the result of the last statement.
  Future<Result<DatabaseSuccess?>> execute({
    required String sql,
    required String? databaseName,
  }) async {
    if (databaseName == null || databaseName.isEmpty) {
      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.noDatabaseSelected),
      );
    }

    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, '$databaseName.db');
      final db = await openDatabase(path);

      final statements = sql
          .split(';')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      DatabaseSuccess? lastResult;

      for (final stmt in statements) {
        final upper = stmt.toUpperCase();

        if (upper.startsWith('SELECT')) {
          final result = await db.rawQuery(stmt);

          lastResult = DatabaseSuccess(result: result);

          _logger.i('Executed SELECT on $databaseName: $stmt');
        } else if (upper.startsWith('DELETE')) {
          final count = await db.rawDelete(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.deleteSuccess,
            args: {'count': count},
          );

          _logger.i('Executed DELETE: $stmt');
        } else if (upper.startsWith('UPDATE')) {
          final count = await db.rawUpdate(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.updateSuccess,
            args: {'count': count},
          );

          _logger.i('Executed UPDATE: $stmt');
        } else if (upper.startsWith('INSERT')) {
          final id = await db.rawInsert(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.insertSuccess,
            args: {'id': id},
          );

          _logger.i('Executed INSERT: $stmt');
        } else {
          await db.execute(stmt);

          lastResult = const DatabaseSuccess(
            type: AppLocalizationsKey.statementSuccess,
          );

          _logger.i('Executed SQL: $stmt');
        }
      }

      if (statements.length > 1) {
        return const SuccessResult(
          DatabaseSuccess(type: AppLocalizationsKey.statementSuccess),
        );
      }

      return SuccessResult(lastResult);
    } on Exception catch (err, stackTrace) {
      _logger.e('Failed to execute SQL', error: err, stackTrace: stackTrace);

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.sqlExecutionError, {'error': err}),
      );
    }
  }

  /// Returns the names of all user tables in [databaseName].
  Future<List<String>> getTables({required String databaseName}) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);
    final result = await db.rawQuery(
      'SELECT name FROM sqlite_master '
      "WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );

    return result.builder((row, index) => row['name']! as String);
  }

  /// Returns the column names of [tableName] in [databaseName].
  Future<List<String>> getTableColumns({
    required String databaseName,
    required String tableName,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);
    final result = await db.rawQuery('PRAGMA table_info($tableName);');

    return result.builder((col, index) => col['name']! as String);
  }

  /// Returns the full table/column/foreign-key structure of
  /// [databaseName].
  Future<List<TableInfoModel>> getDatabaseStructure({
    required String databaseName,
  }) async {
    final path = join(await getDatabasesPath(), '$databaseName.db');
    final db = await openDatabase(path);

    final tableResult = await db.rawQuery(
      'SELECT name FROM sqlite_master '
      "WHERE type='table' AND name NOT LIKE 'sqlite_%' "
      "AND name != 'android_metadata';",
    );

    final tables = <TableInfoModel>[];

    for (final row in tableResult) {
      final name = row['name']! as String;
      final columnsRaw = await db.rawQuery('PRAGMA table_info($name);');
      final fkRaw = await db.rawQuery('PRAGMA foreign_key_list($name);');

      final columns = columnsRaw.builder((col, index) {
        final fk = fkRaw.firstWhere(
          (f) => f['from'] == col['name'],
          orElse: () => {},
        );

        return ColumnInfoModel(
          name: col['name']! as String,
          type: col['type']! as String,
          foreignTable: fk['table'] as String?,
          foreignColumn: fk['to'] as String?,
        );
      });

      tables.add(TableInfoModel(name: name, columns: columns));
    }

    return tables;
  }
}
