import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/repositories/database_repository.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';

class DatabaseService {
  final _logger = Logger();

  final DatabaseRepository<DatabaseModel> _repository;

  DatabaseService({DatabaseRepository<DatabaseModel>? repository})
    : _repository =
          repository ??
          DatabaseRepository<DatabaseModel>(tableName: 'databases');

  Future<Result<void>> create(DatabaseModel model) async {
    try {
      await _repository.insert(model.toMap());

      _logger.i('Database created: ${model.name}');

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to create database',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(DatabaseFailure('Unable to create database: $err'));
    }
  }

  Future<Result<List<DatabaseModel>>> getAll() async {
    try {
      final results = await _repository.getAll(orderBy: 'name ASC');
      final models = results.builder(
        (map, index) => DatabaseModel.fromMap(map),
      );

      _logger.i('Fetched ${models.length} databases');

      return SuccessResult(models);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to fetch databases',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(DatabaseFailure('Unable to fetch databases: $err'));
    }
  }

  Future<Result<DatabaseModel?>> getById(String id) async {
    try {
      final result = await _repository.getById(id);

      if (result != null) {
        final model = DatabaseModel.fromMap(result);

        _logger.i('Fetched database by id: $id');

        return SuccessResult(model);
      }

      _logger.w('No database found with id: $id');

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to retrieve database',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure('Unable to retrieve database: $err'),
      );
    }
  }

  Future<Result<void>> update(DatabaseModel model) async {
    try {
      final updatedCount = await _repository.update(model.toMap());

      if (updatedCount > 0) {
        _logger.i('Database updated: ${model.name}');

        return const SuccessResult(null);
      }

      _logger.w('No record updated for database: ${model.name}');

      return FailureResult(DatabaseFailure('No record was updated.'));
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to update database',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(DatabaseFailure('Unable to update database: $err'));
    }
  }

  Future<Result<void>> delete(DatabaseModel model) async {
    try {
      final deletedCount = await _repository.delete(model.toMap());

      if (deletedCount > 0) {
        _logger.i('Database deleted: ${model.name}');

        return const SuccessResult(null);
      }

      _logger.w('No record deleted for database: ${model.name}');

      return FailureResult(DatabaseFailure('No record was deleted.'));
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to delete database',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(DatabaseFailure('Unable to delete database: $err'));
    }
  }

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
        DatabaseFailure('Unable to update favorite status.'),
      );
    } catch (err, stackTrace) {
      _logger.e('Error toggling favorite', error: err, stackTrace: stackTrace);

      return FailureResult(DatabaseFailure('Error toggling favorite: $err'));
    }
  }

  Future<Result<void>> clearAll() async {
    try {
      await _repository.clear();

      _logger.i('All databases cleared');

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to clear databases',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(DatabaseFailure('Unable to clear databases: $err'));
    }
  }
}
