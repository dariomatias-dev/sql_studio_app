import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Persists a new database.
class CreateDatabaseUseCase {
  /// Creates the use case backed by [_repository].
  const CreateDatabaseUseCase(this._repository);

  final DatabaseRepository _repository;

  /// Runs the use case.
  Future<Result<void>> call(DatabaseEntity model) => _repository.create(model);
}
