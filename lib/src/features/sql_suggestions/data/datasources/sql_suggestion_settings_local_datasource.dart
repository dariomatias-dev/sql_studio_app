import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Reads and writes the raw persisted suggestion-toggle preferences.
class SqlSuggestionSettingsLocalDatasource {
  /// Creates the datasource.
  const SqlSuggestionSettingsLocalDatasource();

  /// Whether basic suggestions are enabled, defaulting to `true`.
  bool getUseBasicSuggestions() {
    return SharedPreferencesService.getBool(
      SharedPreferencesKeys.useBasicSuggestionsKey,
      defaultValue: true,
    );
  }

  /// Whether advanced suggestions are enabled, defaulting to `false`.
  bool getUseAdvancedSuggestions() {
    return SharedPreferencesService.getBool(
      SharedPreferencesKeys.useAdvancedSuggestionsKey,
    );
  }

  /// Whether character-triggered suggestions are enabled, defaulting to
  /// `true`.
  bool getUseCharacterSuggestions() {
    return SharedPreferencesService.getBool(
      SharedPreferencesKeys.useCharacterSuggestionsKey,
      defaultValue: true,
    );
  }

  /// Persists [useBasic], [useAdvanced], and [useCharacter], throwing on
  /// failure.
  Future<void> save({
    required bool useBasic,
    required bool useAdvanced,
    required bool useCharacter,
  }) async {
    await SharedPreferencesService.setBool(
      SharedPreferencesKeys.useBasicSuggestionsKey,
      value: useBasic,
    );

    await SharedPreferencesService.setBool(
      SharedPreferencesKeys.useAdvancedSuggestionsKey,
      value: useAdvanced,
    );

    await SharedPreferencesService.setBool(
      SharedPreferencesKeys.useCharacterSuggestionsKey,
      value: useCharacter,
    );
  }
}
