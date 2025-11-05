class DatabaseMigrations {
  static const databasesTable = '''
    CREATE TABLE IF NOT EXISTS databases (
      id TEXT PRIMARY KEY,
      label TEXT NOT NULL,
      name TEXT NOT NULL,
      is_favorite INTEGER DEFAULT 0,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    )
  ''';

  static const sqlAdvancedSuggestionsTable = '''
    CREATE TABLE IF NOT EXISTS sql_advanced_suggestions (
      id TEXT PRIMARY KEY,
      label TEXT NOT NULL,
      code TEXT NOT NULL,
      select_text TEXT
    )
  ''';

  static const allTables = <String>[
    databasesTable,
    sqlAdvancedSuggestionsTable,
  ];
}
