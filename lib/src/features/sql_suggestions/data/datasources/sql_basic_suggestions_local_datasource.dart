import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';

/// Reads and writes the raw persisted basic SQL suggestions list.
class SqlBasicSuggestionsLocalDatasource {
  /// Creates the datasource.
  const SqlBasicSuggestionsLocalDatasource();

  /// Returns the persisted suggestions, or an empty list when unset.
  List<String> getSuggestions() {
    return SharedPreferencesService.getStringList(
      SharedPreferencesKeys.sqlCommandsKey,
    );
  }

  /// Persists [suggestions], throwing on failure.
  Future<void> setSuggestions(List<String> suggestions) {
    return SharedPreferencesService.setStringList(
      SharedPreferencesKeys.sqlCommandsKey,
      suggestions,
    );
  }
}
