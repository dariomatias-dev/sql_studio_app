import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/features/database/data/datasources/database_local_datasource.dart';

void main() {
  setUpAll(() {
    Logger.level = Level.off;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late DatabaseManager manager;
  late DatabaseLocalDatasource datasource;

  setUp(() async {
    manager = DatabaseManager();
    await manager.deleteDatabaseFile();
    datasource = DatabaseLocalDatasource(manager);
  });

  tearDown(() async {
    await manager.close();
  });

  Map<String, dynamic> database(
    String id, {
    String name = 'todo',
    bool isFavorite = false,
  }) => {
    'id': id,
    'label': 'label $id',
    'name': name,
    'is_favorite': isFavorite ? 1 : 0,
    'created_at': '2024-01-01T00:00:00.000',
    'updated_at': '2024-01-01T00:00:00.000',
  };

  test('insert writes a row into the databases table', () async {
    await datasource.insert(database('a'));

    final rows = await datasource.getAll();

    expect(rows, hasLength(1));
    expect(rows.single['name'], 'todo');
  });

  test('getAll orders rows by the given column', () async {
    await datasource.insert(database('a', name: 'b_db'));
    await datasource.insert(database('b', name: 'a_db'));

    final rows = await datasource.getAll(orderBy: 'name ASC');

    expect(rows.map((r) => r['name']), ['a_db', 'b_db']);
  });

  test('getWhere filters rows by the given conditions', () async {
    await datasource.insert(database('a'));
    await datasource.insert(database('b', name: 'contacts'));

    final rows = await datasource.getWhere(conditions: {'name': 'contacts'});

    expect(rows.map((r) => r['id']), ['b']);
  });

  test('update replaces an existing row', () async {
    await datasource.insert(database('a'));

    await datasource.update(database('a', isFavorite: true));

    final rows = await datasource.getAll();

    expect(rows.single['is_favorite'], 1);
  });

  test('delete removes the row matching the id', () async {
    await datasource.insert(database('a'));
    await datasource.insert(database('b'));

    await datasource.delete({'id': 'a'});

    final rows = await datasource.getAll();

    expect(rows.map((r) => r['id']), ['b']);
  });

  test('dropDatabaseFile removes the SQLite file for the name', () async {
    const name = 'drop_target';

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$name.db');
    await (await databaseFactory.openDatabase(path)).close();
    expect(File(path).existsSync(), isTrue);

    await datasource.dropDatabaseFile(name);

    expect(File(path).existsSync(), isFalse);
  });
}
