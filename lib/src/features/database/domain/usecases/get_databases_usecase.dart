import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Fetches all saved databases.
class GetDatabasesUseCase {
  /// Creates the use case backed by [_repository].
  const GetDatabasesUseCase(this._repository);

  final DatabaseRepository _repository;

  /// Runs the use case.
  Future<Result<List<DatabaseModel>>> call() => _repository.getAll();
}
