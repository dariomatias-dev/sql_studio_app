import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Reads and writes the raw persisted workspace layout preference.
class WorkspaceLayoutLocalDatasource {
  /// Creates the datasource backed by [_prefs].
  const WorkspaceLayoutLocalDatasource(this._prefs);

  final SharedPreferencesService _prefs;

  /// Returns the persisted layout name, or an empty string when unset.
  String getLayoutName() {
    return _prefs.getString(SharedPreferencesKeys.workspaceLayoutKey);
  }

  /// Persists [layoutName], throwing on failure.
  Future<void> setLayoutName(String layoutName) {
    return _prefs.setString(
      SharedPreferencesKeys.workspaceLayoutKey,
      layoutName,
    );
  }
}
