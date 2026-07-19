import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';

/// Restores a default database to its bundled schema and seed data.
class ResetDefaultDatabaseUseCase {
  /// Creates the use case backed by [_repository].
  const ResetDefaultDatabaseUseCase(this._repository);

  final SqlCommandsRepository _repository;

  /// Runs the use case for [databaseName].
  Future<Result<void>> call(String databaseName) =>
      _repository.resetDefaultDatabase(databaseName);
}
