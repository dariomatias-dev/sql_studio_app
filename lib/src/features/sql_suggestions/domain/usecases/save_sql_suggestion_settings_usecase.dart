import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';

/// Persists the current SQL suggestion settings.
class SaveSqlSuggestionSettingsUseCase {
  /// Creates the use case backed by [_repository].
  const SaveSqlSuggestionSettingsUseCase(this._repository);

  final SqlSuggestionSettingsRepository _repository;

  /// Runs the use case.
  Future<Result<void>> call(SqlSuggestionSettingsEntity settings) =>
      _repository.save(settings);
}
