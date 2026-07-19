import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_suggestion_settings_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';

/// [SqlSuggestionSettingsRepository] backed by
/// [SqlSuggestionSettingsLocalDatasource].
class SqlSuggestionSettingsRepositoryImpl
    implements SqlSuggestionSettingsRepository {
  /// Creates the repository with its [_datasource] and [_logger].
  const SqlSuggestionSettingsRepositoryImpl(this._datasource, this._logger);

  final SqlSuggestionSettingsLocalDatasource _datasource;
  final Logger _logger;

  @override
  Future<Result<SqlSuggestionSettingsEntity>> load() async {
    try {
      return SuccessResult(
        SqlSuggestionSettingsEntity(
          useBasicSuggestions: _datasource.getUseBasicSuggestions(),
          useAdvancedSuggestions: _datasource.getUseAdvancedSuggestions(),
          useCharacterSuggestions: _datasource.getUseCharacterSuggestions(),
        ),
      );
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Error loading SQL suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.failedToLoadSqlSuggestions),
      );
    }
  }

  @override
  Future<Result<void>> save(SqlSuggestionSettingsEntity settings) async {
    try {
      await _datasource.save(
        useBasic: settings.useBasicSuggestions,
        useAdvanced: settings.useAdvancedSuggestions,
        useCharacter: settings.useCharacterSuggestions,
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Error saving SQL suggestions settings',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.failedToSaveSqlSuggestionsSettings),
      );
    }
  }
}
