import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Permanently deletes a database: drops its underlying file, then removes
/// its record.
class DeleteDatabaseUseCase {
  /// Creates the use case backed by [_repository].
  const DeleteDatabaseUseCase(this._repository);

  final DatabaseRepository _repository;

  /// Runs the use case for [model].
  Future<Result<void>> call(DatabaseModel model) async {
    final dropResult = await _repository.dropDatabaseFile(model);

    if (dropResult.isFailure) return dropResult;

    return _repository.delete(model);
  }
}
