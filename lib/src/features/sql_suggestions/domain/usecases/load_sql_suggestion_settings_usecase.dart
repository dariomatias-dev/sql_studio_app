import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';

/// Loads the persisted SQL suggestion settings.
class LoadSqlSuggestionSettingsUseCase {
  /// Creates the use case backed by [_repository].
  const LoadSqlSuggestionSettingsUseCase(this._repository);

  final SqlSuggestionSettingsRepository _repository;

  /// Runs the use case.
  Future<Result<SqlSuggestionSettingsEntity>> call() => _repository.load();
}
