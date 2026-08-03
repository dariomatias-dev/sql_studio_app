import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_studio/src/core/database/migrations.dart';

/// Manages the connection to the application's local SQLite database.
/// Instances are meant to be shared via DI (see `databaseManagerProvider`)
/// rather than constructed as a static singleton.
class DatabaseManager {
  static const _databaseName = 'sql_studio_app.db';
  static const _databaseVersion = 1;

  Future<Database>? _initFuture;

  /// The opened database connection, creating it on first access.
  /// Caches the in-flight future (not just the result) so concurrent
  /// callers awaiting before the first open resolves share one
  /// connection instead of racing to open duplicates.
  Future<Database> get database => _initFuture ??= _initDatabase();

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        for (final tableSql in DatabaseMigrations.allTables) {
          await db.execute(tableSql);
        }
      },
    );
  }

  /// Closes the cached connection, if any, and clears it.
  Future<void> close() async {
    final future = _initFuture;
    _initFuture = null;

    await future?.then((db) => db.close());
  }

  /// Closes the connection, deletes the underlying database file, and
  /// clears the cached instance.
  Future<void> deleteDatabaseFile() async {
    await close();

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    await deleteDatabase(path);
  }
}

/// Generic CRUD access to a single SQLite table.
class DatabaseRepository<T> {
  /// Creates a repository bound to [tableName], backed by [manager].
  DatabaseRepository({
    required this.tableName,
    required DatabaseManager manager,
  }) : _manager = manager;

  /// The name of the SQLite table this repository operates on.
  final String tableName;
  final DatabaseManager _manager;

  Future<Database> get _db async => _manager.database;

  /// Inserts [modelMap] into the table, replacing on conflict.
  Future<int> insert(Map<String, dynamic> modelMap) async {
    final db = await _db;

    return db.insert(
      tableName,
      modelMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Inserts all [models] into the table in a single batch.
  Future<List<Object?>> insertAll(List<Map<String, dynamic>> models) async {
    if (models.isEmpty) return <List<Object?>>[];

    final db = await _db;
    final batch = db.batch();

    for (final model in models) {
      batch.insert(
        tableName,
        model,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return batch.commit(noResult: false);
  }

  /// Retrieves all rows from the table, optionally filtered and ordered.
  Future<List<Map<String, dynamic>>> getAll({
    String? orderBy,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await _db;
    final maps = await db.query(
      tableName,
      orderBy: orderBy,
      where: where,
      whereArgs: whereArgs,
    );

    return maps;
  }

  /// Retrieves rows matching all the given [conditions].
  Future<List<Map<String, dynamic>>> getWhere({
    required Map<String, dynamic> conditions,
    String? orderBy,
    int? limit,
  }) async {
    final db = await _db;

    final whereClauses = <String>[];
    final whereArgs = <dynamic>[];

    conditions.forEach((key, value) {
      whereClauses.add('$key = ?');
      whereArgs.add(value);
    });

    final maps = await db.query(
      tableName,
      where: whereClauses.join(' AND '),
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );

    return maps;
  }

  /// Retrieves the row with the given [id], or `null` if none is found.
  Future<Map<String, dynamic>?> getById(String id) async {
    final db = await _db;
    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) return maps.first;

    return null;
  }

  /// Updates the row matching `modelMap['id']` with [modelMap].
  Future<int> update(Map<String, dynamic> modelMap) async {
    final db = await _db;

    return db.update(
      tableName,
      modelMap,
      where: 'id = ?',
      whereArgs: [modelMap['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Updates every row matching each map's `id` in a single batch.
  Future<List<Object?>> updateAll(List<Map<String, dynamic>> models) async {
    if (models.isEmpty) return <List<Object?>>[];

    final db = await _db;
    final batch = db.batch();

    for (final model in models) {
      batch.update(
        tableName,
        model,
        where: 'id = ?',
        whereArgs: [model['id']],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return batch.commit(noResult: false);
  }

  /// Deletes the row with the given [id].
  Future<int> deleteById(String id) async {
    final db = await _db;

    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  /// Deletes the row identified by `modelMap['id']`.
  Future<int> delete(Map<String, dynamic> modelMap) async {
    return deleteById(modelMap['id'] as String);
  }

  /// Removes all rows from the table.
  Future<void> clear() async {
    final db = await _db;

    await db.delete(tableName);
  }

  /// Drops the table named [tableName] if it exists.
  Future<void> dropTable(String tableName) async {
    final db = await _db;

    await db.execute('DROP TABLE IF EXISTS ${_quoteIdentifier(tableName)}');
  }

  /// Quotes [identifier] as an SQLite double-quoted identifier, escaping
  /// embedded double quotes.
  String _quoteIdentifier(String identifier) =>
      '"${identifier.replaceAll('"', '""')}"';

  /// Deletes the SQLite file for the database named [databaseName].
  Future<void> dropDatabaseFile(String databaseName) async {
    final dbPath = await getDatabasesPath();

    final fullPath = join(dbPath, '$databaseName.db');

    await deleteDatabase(fullPath);
  }
}
