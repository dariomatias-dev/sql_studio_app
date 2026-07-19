import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';

/// Reads and writes the raw persisted workspace layout preference.
class WorkspaceLayoutLocalDatasource {
  /// Creates the datasource.
  const WorkspaceLayoutLocalDatasource();

  /// Returns the persisted layout name, or an empty string when unset.
  String getLayoutName() {
    return SharedPreferencesService.getString(
      SharedPreferencesKeys.workspaceLayoutKey,
    );
  }

  /// Persists [layoutName], throwing on failure.
  Future<void> setLayoutName(String layoutName) {
    return SharedPreferencesService.setString(
      SharedPreferencesKeys.workspaceLayoutKey,
      layoutName,
    );
  }
}
