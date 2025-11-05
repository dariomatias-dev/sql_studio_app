import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sql_studio/src/repositories/migrations.dart';

class DatabaseManager {
  static const _databaseName = 'sql_studio_app.db';
  static const _databaseVersion = 1;

  static Database? _instance;

  static final _singleton = DatabaseManager._internal();

  DatabaseManager._internal();
  factory DatabaseManager() => _singleton;

  Future<Database> get database async {
    if (_instance != null) return _instance!;

    _instance = await _initDatabase();

    return _instance!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        for (var tableSql in DatabaseMigrations.allTables) {
          await db.execute(tableSql);
        }
      },
    );
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    await deleteDatabase(path);

    _instance = null;
  }
}

class DatabaseRepository<T> {
  final String tableName;
  final _manager = DatabaseManager();

  DatabaseRepository({required this.tableName});

  Future<Database> get _db async => await _manager.database;

  Future<int> insert(Map<String, dynamic> modelMap) async {
    final db = await _db;

    return db.insert(
      tableName,
      modelMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

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

    return await batch.commit(noResult: false);
  }

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

  Future<int> deleteById(String id) async {
    final db = await _db;

    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(Map<String, dynamic> modelMap) async {
    return deleteById(modelMap['id']);
  }

  Future<void> clear() async {
    final db = await _db;

    await db.delete(tableName);
  }

  Future<void> dropTable() async {
    final db = await _db;

    await db.execute('DROP TABLE IF EXISTS $tableName');
  }
}
