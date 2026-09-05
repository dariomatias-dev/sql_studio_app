import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Flips the favorite flag of a database and persists the change.
class ToggleDatabaseFavoriteUseCase {
  /// Creates the use case backed by [_repository].
  const ToggleDatabaseFavoriteUseCase(this._repository);

  final DatabaseRepository _repository;

  /// Runs the use case for [model].
  Future<Result<DatabaseEntity>> call(DatabaseEntity model) =>
      _repository.toggleFavorite(model);
}
