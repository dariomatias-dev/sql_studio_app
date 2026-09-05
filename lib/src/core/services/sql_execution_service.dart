import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/sql/sql_statement_splitter.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';

/// Executes raw SQL statements against a named SQLite database and
/// inspects its structure.
class SqlExecutionService {
  /// Creates the service, recording failures through [_logger].
  SqlExecutionService(this._logger);

  final AppLogger _logger;
  final _databases = <String, Database>{};

  Future<Database> _openDatabase(String databaseName) async {
    final cached = _databases[databaseName];
    if (cached != null) return cached;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);

    _databases[databaseName] = db;

    return db;
  }

  /// Closes and evicts the cached connection for [databaseName], if any.
  /// Call this before the underlying database file is deleted so a later
  /// reuse of the same name doesn't hand back a stale handle.
  Future<void> closeDatabase(String databaseName) async {
    final db = _databases.remove(databaseName);
    await db?.close();
  }

  /// Closes and evicts every cached connection. Call this when the
  /// service is disposed so no SQLite handle outlives it.
  Future<void> closeAll() async {
    final databases = _databases.values.toList();
    _databases.clear();

    for (final db in databases) {
      await db.close();
    }
  }

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
      final db = await _openDatabase(databaseName);

      final statements = splitSqlStatements(sql);

      DatabaseSuccess? lastResult;

      for (final stmt in statements) {
        final upper = _stripLeadingComments(stmt).toUpperCase();

        if (upper.startsWith('SELECT') || upper.startsWith('WITH')) {
          final result = await db.rawQuery(stmt);

          lastResult = DatabaseSuccess(result: result);

          _logger.info('Executed SELECT: ${result.length} rows');
        } else if (upper.startsWith('DELETE')) {
          final count = await db.rawDelete(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.deleteSuccess,
            args: {'count': count},
          );

          _logger.info('Executed DELETE: $count rows');
        } else if (upper.startsWith('UPDATE')) {
          final count = await db.rawUpdate(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.updateSuccess,
            args: {'count': count},
          );

          _logger.info('Executed UPDATE: $count rows');
        } else if (upper.startsWith('INSERT')) {
          final id = await db.rawInsert(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.insertSuccess,
            args: {'id': id},
          );

          _logger.info('Executed INSERT');
        } else {
          await db.execute(stmt);

          lastResult = const DatabaseSuccess(
            type: AppLocalizationsKey.statementSuccess,
          );

          _logger.info('Executed statement');
        }
      }

      return SuccessResult(lastResult);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to execute SQL',
        error: kDebugMode ? err : err.runtimeType,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.sqlExecutionError, {'error': err}),
      );
    }
  }

  /// Strips leading `--` line comments and `/* */` block comments so
  /// statement-type detection isn't fooled by a commented-out prefix.
  String _stripLeadingComments(String sql) {
    var result = sql.trimLeft();

    while (true) {
      if (result.startsWith('--')) {
        final newlineIndex = result.indexOf('\n');
        result = newlineIndex == -1
            ? ''
            : result.substring(newlineIndex + 1).trimLeft();
      } else if (result.startsWith('/*')) {
        final endIndex = result.indexOf('*/');
        result = endIndex == -1
            ? ''
            : result.substring(endIndex + 2).trimLeft();
      } else {
        break;
      }
    }

    return result;
  }

  /// Quotes [identifier] as an SQLite double-quoted identifier, escaping
  /// embedded double quotes.
  String _quoteIdentifier(String identifier) =>
      '"${identifier.replaceAll('"', '""')}"';

  /// Returns the names of all user tables in [databaseName].
  Future<List<String>> getTables({required String databaseName}) async {
    final db = await _openDatabase(databaseName);
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
    final db = await _openDatabase(databaseName);
    final result = await db.rawQuery(
      'PRAGMA table_info(${_quoteIdentifier(tableName)});',
    );

    return result.builder((col, index) => col['name']! as String);
  }

  /// Returns the full table/column/foreign-key structure of
  /// [databaseName].
  Future<List<TableInfoEntity>> getDatabaseStructure({
    required String databaseName,
  }) async {
    final db = await _openDatabase(databaseName);

    final tableResult = await db.rawQuery(
      'SELECT name FROM sqlite_master '
      "WHERE type='table' AND name NOT LIKE 'sqlite_%' "
      "AND name != 'android_metadata';",
    );

    final tables = <TableInfoEntity>[];

    for (final row in tableResult) {
      final name = row['name']! as String;
      final quotedName = _quoteIdentifier(name);
      final results = await Future.wait([
        db.rawQuery('PRAGMA table_info($quotedName);'),
        db.rawQuery('PRAGMA foreign_key_list($quotedName);'),
      ]);
      final columnsRaw = results[0];
      final fkRaw = results[1];

      final columns = columnsRaw.builder((col, index) {
        final fk = fkRaw.firstWhere(
          (f) => f['from'] == col['name'],
          orElse: () => {},
        );

        return ColumnInfoEntity(
          name: col['name']! as String,
          type: col['type']! as String,
          foreignTable: fk['table'] as String?,
          foreignColumn: fk['to'] as String?,
        );
      });

      tables.add(TableInfoEntity(name: name, columns: columns));
    }

    return tables;
  }
}
