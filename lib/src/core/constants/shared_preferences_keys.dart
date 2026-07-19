/// Keys used to read and write values in shared preferences.
class SharedPreferencesKeys {
  /// Key for the persisted app locale.
  static const localeKey = 'locale';

  /// Key for the persisted SQL command history.
  static const sqlCommandsKey = 'sql_commands';

  /// Key for the currently selected database.
  static const selectedDatabaseKey = 'selected_database';

  /// Key for the persisted workspace layout.
  static const workspaceLayoutKey = 'workspace_layout';

  /// Key for the installed version of the default databases.
  static const defaultDatabaseVersionKey = 'default_database_version';

  /// Key for whether basic SQL suggestions are enabled.
  static const useBasicSuggestionsKey = 'use_basic_suggestions';

  /// Key for whether advanced SQL suggestions are enabled.
  static const useAdvancedSuggestionsKey = 'use_advanced_suggestions';

  /// Key for whether character-based SQL suggestions are enabled.
  static const useCharacterSuggestionsKey = 'use_character_suggestions';
}
