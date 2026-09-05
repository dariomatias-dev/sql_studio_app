import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/database/data/datasources/database_local_datasource.dart';
import 'package:sql_studio/src/features/database/data/mappers/database_mapper.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart'
    as domain;

/// [domain.DatabaseRepository] backed by [DatabaseLocalDatasource].
class DatabaseRepositoryImpl implements domain.DatabaseRepository {
  /// Creates the repository with its [_datasource] and [_logger].
  const DatabaseRepositoryImpl(this._datasource, this._logger);

  final DatabaseLocalDatasource _datasource;
  final AppLogger _logger;

  @override
  Future<Result<void>> create(DatabaseEntity model) async {
    try {
      await _datasource.insert(DatabaseMapper.toMap(model));

      _logger.info('Database created');

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
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
  Future<Result<List<DatabaseEntity>>> getAll() async {
    try {
      final results = await _datasource.getAll(orderBy: 'name ASC');
      final models = results.map(DatabaseMapper.fromMap).toList();

      _logger.info('Fetched ${models.length} databases');

      return SuccessResult(models);
    } on Exception catch (err, stackTrace) {
      _logger.error(
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
  Future<Result<DatabaseEntity?>> getByName(String name) async {
    try {
      final results = await _datasource.getWhere(
        conditions: {'name': name},
        limit: 1,
      );

      if (results.isNotEmpty) {
        final model = DatabaseMapper.fromMap(results.first);

        _logger.info('Fetched database by name');

        return SuccessResult(model);
      }

      _logger.warning('No database found with the given name');

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
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
  Future<Result<void>> delete(DatabaseEntity model) async {
    try {
      final deletedCount = await _datasource.delete(
        DatabaseMapper.toMap(model),
      );

      if (deletedCount > 0) {
        _logger.info('Database deleted');

        return const SuccessResult(null);
      }

      _logger.warning('No record deleted for the database');

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.noRecordDeleted),
      );
    } on Exception catch (err, stackTrace) {
      _logger.error(
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
  Future<Result<DatabaseEntity>> toggleFavorite(DatabaseEntity model) async {
    try {
      final updated = model.copyWith(
        isFavorite: !model.isFavorite,
        updatedAt: DateTime.now(),
      );
      final updatedCount = await _datasource.update(
        DatabaseMapper.toMap(updated),
      );

      if (updatedCount > 0) {
        _logger.info('Toggled favorite for the database');

        return SuccessResult(updated);
      }

      _logger.warning('Unable to toggle favorite for the database');

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.toggleDatabaseFavoriteError, {
          'databaseName': model.name,
        }),
      );
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Error toggling favorite',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.toggleDatabaseFavoriteError, {
          'databaseName': model.name,
        }),
      );
    }
  }

  @override
  Future<Result<void>> dropDatabaseFile(DatabaseEntity model) async {
    try {
      await _datasource.dropDatabaseFile(model.name);

      _logger.info('Complete drop executed');

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
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
