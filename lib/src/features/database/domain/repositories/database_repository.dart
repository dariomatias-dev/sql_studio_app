import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';

/// Persists and retrieves the user's saved databases.
///
/// Uses [DatabaseModel] directly as its data contract: the model already
/// extends the domain entity, so operations return it instead of a
/// separate, duplicate read type.
abstract interface class DatabaseRepository {
  /// Persists a new database record.
  Future<Result<void>> create(DatabaseModel model);

  /// Fetches all database records ordered by name.
  Future<Result<List<DatabaseModel>>> getAll();

  /// Fetches the database record matching [name], if any.
  Future<Result<DatabaseModel?>> getByName(String name);

  /// Deletes the record for [model].
  Future<Result<void>> delete(DatabaseModel model);

  /// Flips the favorite flag of [model] and persists the change.
  Future<Result<void>> toggleFavorite(DatabaseModel model);

  /// Deletes the underlying database file for [model].
  Future<Result<void>> dropDatabaseFile(DatabaseModel model);
}
