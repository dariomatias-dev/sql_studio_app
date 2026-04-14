class RouteNames {
  static const splash = '/splash';

  static const main = '/';

  static const database = 'database';
  static const databasePath = '$main$database';

  static String databaseVisualizerFn(String dbName) =>
      '/database-visualizer/$dbName';
  static const databaseVisualizerPath = '/database-visualizer/:dbName';
  static const databaseVisualizer = '/database-visualizer';

  static const sqlBasicSuggestionSettings =
      '/settings/sql-basic-suggestion-settings';

  static const sqlAdvancedSuggestionSettings =
      '/settings/sql-advanced-suggestion-settings';

  static const sqlSuggestionSettingsPath = '/settings/sql-suggestion-settings';

  static const workspaceLayoutSettings = '/settings/workspace-layout-settings';
}
