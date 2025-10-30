import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sql_studio/src/core/result.dart';

class SqlExecutionService {
  final _logger = Logger();

  Future<Result<dynamic>> execute({
    required String sql,
    required String? databaseName,
  }) async {
    if (databaseName == null || databaseName.isEmpty) {
      return FailureResult(DatabaseFailure('No active database selected.'));
    }

    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, '$databaseName.db');

      final db = await openDatabase(path);

      final trimmed = sql.trim().toUpperCase();
      final isSelect = trimmed.startsWith('SELECT');

      if (isSelect) {
        final result = await db.rawQuery(sql);

        _logger.i('Executed SELECT on $databaseName: $sql');

        return SuccessResult(result);
      }

      await db.execute(sql);

      _logger.i('Executed SQL on $databaseName: $sql');

      return const SuccessResult('Success');
    } catch (err, stackTrace) {
      _logger.e('Failed to execute SQL', error: err, stackTrace: stackTrace);

      return FailureResult(DatabaseFailure('SQL execution error: $err'));
    }
  }

  Future<List<String>> getTableColumns({
    required String databaseName,
    required String tableName,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);
    final result = await db.rawQuery('PRAGMA table_info($tableName);');

    return result.map((col) => col['name'] as String).toList();
  }
}
