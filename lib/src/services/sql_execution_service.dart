import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/core/result.dart';
import 'package:sql_studio/src/core/types/table_info.dart';

class SqlExecutionService {
  final _logger = Logger();

  Future<Result<dynamic>> execute({
    required String sql,
    required String? databaseName,
  }) async {
    if (databaseName == null || databaseName.isEmpty) {
      return FailureResult(
        DatabaseFailure('No active database. Select a database.'),
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

      dynamic lastResult;

      for (final stmt in statements) {
        final upper = stmt.toUpperCase();

        if (upper.startsWith('SELECT')) {
          lastResult = await db.rawQuery(stmt);
          _logger.i('Executed SELECT on $databaseName: $stmt');
        } else if (upper.startsWith('DELETE')) {
          final count = await db.rawDelete(stmt);
          lastResult = 'Delete executed successfully. $count rows affected.';
          _logger.i('Executed DELETE: $stmt');
        } else if (upper.startsWith('UPDATE')) {
          final count = await db.rawUpdate(stmt);
          lastResult = 'Update executed successfully. $count rows affected.';
          _logger.i('Executed UPDATE: $stmt');
        } else if (upper.startsWith('INSERT')) {
          final id = await db.rawInsert(stmt);
          lastResult = 'Insert executed successfully. Inserted row ID: $id.';
          _logger.i('Executed INSERT: $stmt');
        } else {
          await db.execute(stmt);
          lastResult = 'Statement executed successfully.';
          _logger.i('Executed SQL: $stmt');
        }
      }

      if (statements.length > 1) {
        return SuccessResult('Statement executed successfully.');
      }

      return SuccessResult(lastResult);
    } catch (err, stackTrace) {
      _logger.e('Failed to execute SQL', error: err, stackTrace: stackTrace);

      return FailureResult(DatabaseFailure('SQL execution error: $err'));
    }
  }

  Future<List<String>> getTables({required String databaseName}) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );

    return result.builder((row, index) => row['name'] as String);
  }

  Future<List<String>> getTableColumns({
    required String databaseName,
    required String tableName,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);
    final result = await db.rawQuery('PRAGMA table_info($tableName);');

    return result.builder((col, index) => col['name'] as String);
  }

  Future<List<TableInfo>> getDatabaseStructure({
    required String databaseName,
  }) async {
    final path = join(await getDatabasesPath(), '$databaseName.db');
    final db = await openDatabase(path);

    final tableResult = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name != 'android_metadata';",
    );

    final tables = <TableInfo>[];

    for (final row in tableResult) {
      final name = row['name'] as String;
      final columnsRaw = await db.rawQuery('PRAGMA table_info($name);');
      final fkRaw = await db.rawQuery('PRAGMA foreign_key_list($name);');

      final columns = columnsRaw.builder((col, index) {
        final fk = fkRaw.firstWhere(
          (f) => f['from'] == col['name'],
          orElse: () => {},
        );

        return ColumnInfo(
          name: col['name'] as String,
          type: col['type'] as String,
          foreignTable: fk['table'] as String?,
          foreignColumn: fk['to'] as String?,
        );
      });

      tables.add(TableInfo(name: name, columns: columns));
    }

    return tables;
  }
}
