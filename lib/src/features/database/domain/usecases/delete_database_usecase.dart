import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Permanently deletes a database: closes its cached connection, drops its
/// underlying file, then removes its record.
class DeleteDatabaseUseCase {
  /// Creates the use case backed by [_repository] and [_sqlExecutionService].
  const DeleteDatabaseUseCase(this._repository, this._sqlExecutionService);

  final DatabaseRepository _repository;
  final SqlExecutionService _sqlExecutionService;

  /// Runs the use case for [model].
  Future<Result<void>> call(DatabaseModel model) async {
    await _sqlExecutionService.closeDatabase(model.name);

    final dropResult = await _repository.dropDatabaseFile(model);

    if (dropResult.isFailure) return dropResult;

    return _repository.delete(model);
  }
}
