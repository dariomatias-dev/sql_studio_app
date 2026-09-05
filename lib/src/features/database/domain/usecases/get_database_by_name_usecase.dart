import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Fetches a saved database by its name.
class GetDatabaseByNameUseCase {
  /// Creates the use case backed by [_repository].
  const GetDatabaseByNameUseCase(this._repository);

  final DatabaseRepository _repository;

  /// Runs the use case for the database named [name].
  Future<Result<DatabaseEntity?>> call(String name) =>
      _repository.getByName(name);
}
