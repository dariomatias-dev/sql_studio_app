import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/datasources/database_local_datasource.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart'
    as domain;

/// [domain.DatabaseRepository] backed by [DatabaseLocalDatasource].
class DatabaseRepositoryImpl implements domain.DatabaseRepository {
  /// Creates the repository with its [_datasource] and [_logger].
  const DatabaseRepositoryImpl(this._datasource, this._logger);

  final DatabaseLocalDatasource _datasource;
  final Logger _logger;

  @override
  Future<Result<void>> create(DatabaseModel model) async {
    try {
      await _datasource.insert(model.toMap());

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

  @override
  Future<Result<List<DatabaseModel>>> getAll() async {
    try {
      final results = await _datasource.getAll(orderBy: 'name ASC');
      final models = results.map(DatabaseModel.fromMap).toList();

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

  @override
  Future<Result<DatabaseModel?>> getByName(String name) async {
    try {
      final results = await _datasource.getWhere(
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

  @override
  Future<Result<void>> delete(DatabaseModel model) async {
    try {
      final deletedCount = await _datasource.delete(model.toMap());

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

  @override
  Future<Result<DatabaseModel>> toggleFavorite(DatabaseModel model) async {
    try {
      final updated = model.copyWith(
        isFavorite: !model.isFavorite,
        updatedAt: DateTime.now(),
      );
      final updatedCount = await _datasource.update(updated.toMap());

      if (updatedCount > 0) {
        _logger.i('Toggled favorite for database: ${model.name}');

        return SuccessResult(updated);
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

  @override
  Future<Result<void>> dropDatabaseFile(DatabaseModel model) async {
    try {
      await _datasource.dropDatabaseFile(model.name);

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
