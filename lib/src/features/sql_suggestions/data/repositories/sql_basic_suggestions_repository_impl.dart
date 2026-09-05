import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_basic_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';

/// [SqlBasicSuggestionsRepository] backed by
/// [SqlBasicSuggestionsLocalDatasource].
class SqlBasicSuggestionsRepositoryImpl
    implements SqlBasicSuggestionsRepository {
  /// Creates the repository with its [_datasource] and [_logger].
  const SqlBasicSuggestionsRepositoryImpl(this._datasource, this._logger);

  final SqlBasicSuggestionsLocalDatasource _datasource;
  final AppLogger _logger;

  @override
  Future<Result<List<String>>> load() async {
    try {
      final stored = _datasource.getSuggestions();

      return SuccessResult(
        stored.isEmpty ? List<String>.from(defaultSqlBasicSuggestions) : stored,
      );
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to load suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToLoadBasicSuggestions),
      );
    }
  }

  @override
  Future<Result<void>> save(List<String> suggestions) async {
    try {
      await _datasource.setSuggestions(suggestions);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to save suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToUpdateBasicSuggestions),
      );
    }
  }
}
