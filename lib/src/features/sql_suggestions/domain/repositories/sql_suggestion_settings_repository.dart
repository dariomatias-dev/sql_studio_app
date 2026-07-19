import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';

/// Persists and retrieves which SQL suggestion features are enabled.
abstract interface class SqlSuggestionSettingsRepository {
  /// Reads the persisted settings.
  Future<Result<SqlSuggestionSettingsEntity>> load();

  /// Persists [settings].
  Future<Result<void>> save(SqlSuggestionSettingsEntity settings);
}
