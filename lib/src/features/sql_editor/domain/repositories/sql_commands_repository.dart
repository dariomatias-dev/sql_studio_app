import 'package:sql_studio/src/core/error/result.dart';

/// Runs SQL statements and inspects table structure for a named database.
abstract interface class SqlCommandsRepository {
  /// Runs one or more semicolon-separated [sql] statements against
  /// [databaseName], returning the result of the last statement.
  Future<Result<DatabaseSuccess?>> execute({
    required String sql,
    required String databaseName,
  });

  /// Returns the column names of [tableName] in [databaseName].
  Future<List<String>> getTableColumns({
    required String databaseName,
    required String tableName,
  });

  /// Restores the default database named [databaseName] to its bundled
  /// schema and seed data.
  Future<Result<void>> resetDefaultDatabase(String databaseName);
}
