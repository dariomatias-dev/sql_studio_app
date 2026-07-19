import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Persists a new database.
class CreateDatabaseUseCase {
  /// Creates the use case backed by [_repository].
  const CreateDatabaseUseCase(this._repository);

  final DatabaseRepository _repository;

  /// Runs the use case.
  Future<Result<void>> call(DatabaseModel model) => _repository.create(model);
}
