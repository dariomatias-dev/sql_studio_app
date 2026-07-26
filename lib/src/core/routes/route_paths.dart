/// URI paths used to build each route in the application.
class RoutePaths {
  /// Path of the splash screen.
  static const splash = '/splash';

  /// Path of the main screen.
  static const main = '/';

  /// Path of the database screen.
  static const database = '/database';

  /// Path of the database visualizer screen.
  static const databaseVisualizer = '/database-visualizer/:dbName';

  /// Path of the SQL basic suggestion settings screen.
  static const sqlBasicSuggestionSettings =
      '/settings/sql-basic-suggestion-settings';

  /// Path of the SQL advanced suggestion settings screen.
  static const sqlAdvancedSuggestionSettings =
      '/settings/sql-advanced-suggestion-settings';

  /// Path of the SQL suggestion settings screen.
  static const sqlSuggestionSettings = '/settings/sql-suggestion-settings';

  /// Path of the workspace layout settings screen.
  static const workspaceLayoutSettings = '/settings/workspace-layout-settings';

  /// Path of the about screen.
  static const about = '/settings/about';
}
