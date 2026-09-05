import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// [SqlAdvancedSuggestionsRepository] backed by
/// [SqlAdvancedSuggestionsLocalDatasource].
class SqlAdvancedSuggestionsRepositoryImpl
    implements SqlAdvancedSuggestionsRepository {
  /// Creates the repository with its [_datasource] and [_logger].
  const SqlAdvancedSuggestionsRepositoryImpl(this._datasource, this._logger);

  final SqlAdvancedSuggestionsLocalDatasource _datasource;
  final AppLogger _logger;

  @override
  Future<Result<List<SqlAdvancedSuggestionModel>>> getAll() async {
    try {
      final maps = await _datasource.getAll();

      if (maps.isEmpty) {
        final defaults = List<SqlAdvancedSuggestionModel>.from(
          defaultSqlAdvancedSuggestions,
        );

        await _datasource.insertAll(defaults.map((m) => m.toMap()).toList());

        return SuccessResult(defaults);
      }

      return SuccessResult(
        maps.map(SqlAdvancedSuggestionModel.fromMap).toList(),
      );
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to load advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToLoadAdvancedSuggestions),
      );
    }
  }

  @override
  Future<Result<void>> create(SqlAdvancedSuggestionModel model) async {
    try {
      await _datasource.insert(model.toMap());

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to add advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToAddAdvancedSuggestion),
      );
    }
  }

  @override
  Future<Result<void>> addAll(List<SqlAdvancedSuggestionModel> models) async {
    if (models.isEmpty) return const SuccessResult(null);

    try {
      await _datasource.insertAll(models.map((m) => m.toMap()).toList());

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to save all advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveAllAdvancedSuggestions),
      );
    }
  }

  @override
  Future<Result<void>> update(SqlAdvancedSuggestionModel model) async {
    try {
      await _datasource.update(model.toMap());

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to update advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToUpdateAdvancedSuggestion),
      );
    }
  }

  @override
  Future<Result<void>> updateAll(
    List<SqlAdvancedSuggestionModel> models,
  ) async {
    if (models.isEmpty) return const SuccessResult(null);

    try {
      await _datasource.updateAll(models.map((m) => m.toMap()).toList());

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to reorder advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToReorderAdvancedSuggestions),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _datasource.deleteById(id);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to remove advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToRemoveAdvancedSuggestion),
      );
    }
  }

  @override
  Future<Result<void>> clear() async {
    try {
      await _datasource.clear();

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to clear advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(AppFailure(AppLocalizationsKey.unableToClear));
    }
  }
}
