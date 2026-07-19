/// SQL statements used to create the application's local database tables.
class DatabaseMigrations {
  /// Creates the `databases` table, which stores registered database
  /// records.
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

  /// Creates the `sql_advanced_suggestions` table, which stores advanced
  /// SQL autocomplete suggestions.
  static const sqlAdvancedSuggestionsTable = '''
  CREATE TABLE IF NOT EXISTS sql_advanced_suggestions (
    id TEXT PRIMARY KEY,
    label TEXT NOT NULL,
    code TEXT NOT NULL,
    select_text TEXT,
    order_index INTEGER NOT NULL
  )
''';

  /// All table creation statements to run when the database is created.
  static const allTables = <String>[
    databasesTable,
    sqlAdvancedSuggestionsTable,
  ];
}
