import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

/// Persists and retrieves the user's saved databases.
///
/// Uses [DatabaseEntity] directly as its data contract: the model already
/// extends the domain entity, so operations return it instead of a
/// separate, duplicate read type.
abstract interface class DatabaseRepository {
  /// Persists a new database record.
  Future<Result<void>> create(DatabaseEntity model);

  /// Fetches all database records ordered by name.
  Future<Result<List<DatabaseEntity>>> getAll();

  /// Fetches the database record matching [name], if any.
  Future<Result<DatabaseEntity?>> getByName(String name);

  /// Deletes the record for [model].
  Future<Result<void>> delete(DatabaseEntity model);

  /// Flips the favorite flag of [model], persists the change, and returns
  /// the updated record.
  Future<Result<DatabaseEntity>> toggleFavorite(DatabaseEntity model);

  /// Deletes the underlying database file for [model].
  Future<Result<void>> dropDatabaseFile(DatabaseEntity model);
}
