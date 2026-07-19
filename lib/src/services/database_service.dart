import 'package:logger/logger.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/repositories/database_repository.dart';

/// Manages CRUD operations for [DatabaseModel] records.
class DatabaseService {
  /// Creates a service backed by [repository], or a default
  /// repository targeting the `databases` table if none is given.
  DatabaseService({DatabaseRepository<DatabaseModel>? repository})
    : _repository =
          repository ??
          DatabaseRepository<DatabaseModel>(tableName: 'databases');
  final _logger = Logger();

  final DatabaseRepository<DatabaseModel> _repository;

  /// Persists a new database record.
  Future<Result<void>> create(DatabaseModel model) async {
    try {
      await _repository.insert(model.toMap());

      _logger.i('Database created: ${model.name}');

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to create database',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.databaseCreationError, {
          'databaseName': model.name,
        }),
      );
    }
  }

  /// Fetches all database records ordered by name.
  Future<Result<List<DatabaseModel>>> getAll() async {
    try {
      final results = await _repository.getAll(orderBy: 'name ASC');
      final models = results.builder(
        (map, index) => DatabaseModel.fromMap(map),
      );

      _logger.i('Fetched ${models.length} databases');

      return SuccessResult(models);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to fetch databases',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.fetchDatabasesError),
      );
    }
  }

  /// Fetches the database record matching [name], if any.
  Future<Result<DatabaseModel?>> getByName(String name) async {
    try {
      final results = await _repository.getWhere(
        conditions: {'name': name},
        limit: 1,
      );

      if (results.isNotEmpty) {
        final model = DatabaseModel.fromMap(results.first);

        _logger.i('Fetched database by name: $name');

        return SuccessResult(model);
      }

      _logger.w('No database found with name: $name');

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to retrieve database by name',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.checkDatabaseExistsError),
      );
    }
  }

  /// Deletes the record for [model].
  Future<Result<void>> delete(DatabaseModel model) async {
    try {
      final deletedCount = await _repository.delete(model.toMap());

      if (deletedCount > 0) {
        _logger.i('Database deleted: ${model.name}');

        return const SuccessResult(null);
      }

      _logger.w('No record deleted for database: ${model.name}');

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.noRecordDeleted),
      );
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to delete database',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.deleteDatabaseError, {
          'databaseName': model.name,
        }),
      );
    }
  }

  /// Flips the favorite flag of [model] and persists the change.
  Future<Result<void>> toggleFavorite(DatabaseModel model) async {
    try {
      final updated = model.copyWith(
        isFavorite: !model.isFavorite,
        updatedAt: DateTime.now(),
      );
      final updatedCount = await _repository.update(updated.toMap());

      if (updatedCount > 0) {
        _logger.i('Toggled favorite for database: ${model.name}');

        return const SuccessResult(null);
      }

      _logger.w('Unable to toggle favorite for database: ${model.name}');

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.toggleDatabaseFavoriteError, {
          'databaseName': model.name,
        }),
      );
    } on Exception catch (err, stackTrace) {
      _logger.e('Error toggling favorite', error: err, stackTrace: stackTrace);

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.toggleDatabaseFavoriteError, {
          'databaseName': model.name,
        }),
      );
    }
  }

  /// Deletes the underlying database file for [model].
  Future<Result<void>> dropTable(DatabaseModel model) async {
    try {
      await _repository.dropDatabaseFile(model.name);

      _logger.i('Complete drop executed for: ${model.name}');

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to perform complete drop for: ${model.name}',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.deleteDatabaseError, {
          'databaseName': model.name,
        }),
      );
    }
  }
}
