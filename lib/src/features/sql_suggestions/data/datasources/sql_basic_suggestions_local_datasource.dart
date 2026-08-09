import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Reads and writes the raw persisted basic SQL suggestions list.
class SqlBasicSuggestionsLocalDatasource {
  /// Creates the datasource backed by [_prefs].
  const SqlBasicSuggestionsLocalDatasource(this._prefs);

  final SharedPreferencesService _prefs;

  /// Returns the persisted suggestions, or an empty list when unset.
  List<String> getSuggestions() {
    return _prefs.getStringList(SharedPreferencesKeys.sqlCommandsKey);
  }

  /// Persists [suggestions], throwing on failure.
  Future<void> setSuggestions(List<String> suggestions) {
    return _prefs.setStringList(
      SharedPreferencesKeys.sqlCommandsKey,
      suggestions,
    );
  }
}
