class DatabaseMigrations {
  static const createDatabasesTable = '''
    CREATE TABLE IF NOT EXISTS databases (
      id TEXT PRIMARY KEY,
      label TEXT NOT NULL,
      name TEXT NOT NULL,
      is_favorite INTEGER DEFAULT 0,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    )
  ''';

  static const allTables = <String>[
    createDatabasesTable,
  ];
}
