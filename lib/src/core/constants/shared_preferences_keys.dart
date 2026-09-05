/// Keys used to read and write values in shared preferences.
class SharedPreferencesKeys {
  /// Key for the persisted app locale.
  static const localeKey = 'locale';

  /// Key for the persisted app theme mode.
  static const themeModeKey = 'theme_mode';

  /// Key for the persisted SQL command history.
  static const sqlCommandsKey = 'sql_commands';

  /// Key for the currently selected database.
  static const selectedDatabaseKey = 'selected_database';

  /// Key for the persisted workspace layout.
  static const workspaceLayoutKey = 'workspace_layout';

  /// Key for the single version that used to cover every default
  /// database. Only read to migrate to the per-database keys.
  static const legacyDefaultDatabaseVersionKey = 'default_database_version';

  /// Key for the installed seed version of the default database [name].
  static String defaultDatabaseVersionKey(String name) =>
      'default_database_version_$name';

  /// Key for whether basic SQL suggestions are enabled.
  static const useBasicSuggestionsKey = 'use_basic_suggestions';

  /// Key for whether advanced SQL suggestions are enabled.
  static const useAdvancedSuggestionsKey = 'use_advanced_suggestions';

  /// Key for whether character-based SQL suggestions are enabled.
  static const useCharacterSuggestionsKey = 'use_character_suggestions';
}
