import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';

/// Runs a SQL query against a named database.
class RunSqlQueryUseCase {
  /// Creates the use case backed by [_repository].
  const RunSqlQueryUseCase(this._repository);

  final SqlCommandsRepository _repository;

  /// Runs the use case for [sql] against [databaseName].
  Future<Result<DatabaseSuccess?>> call({
    required String sql,
    required String databaseName,
  }) {
    return _repository.execute(sql: sql, databaseName: databaseName);
  }
}
