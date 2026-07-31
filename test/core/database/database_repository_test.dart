import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/database/database_repository.dart';

void main() {
  setUpAll(() {
    Logger.level = Level.off;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late DatabaseManager manager;

  /// onCreate only runs once per physical file, so each test starts from
  /// a clean slate instead of reusing a previous run's leftover file.
  setUp(() async {
    manager = DatabaseManager();
    await manager.deleteDatabaseFile();
  });

  tearDown(() async {
    await manager.close();
  });

  group('DatabaseManager', () {
    test('database creates and caches the connection', () async {
      final db = await manager.database;

      expect(db.isOpen, isTrue);
      expect(identical(await manager.database, db), isTrue);
    });

    test('onCreate provisions the expected tables', () async {
      final db = await manager.database;

      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table'",
      );
      final names = tables.map((row) => row['name']).toSet();

      expect(names, containsAll(['databases', 'sql_advanced_suggestions']));
    });

    test('close clears the cached connection', () async {
      final db = await manager.database;

      await manager.close();

      expect(db.isOpen, isFalse);
    });

    test('close is a no-op when never opened', () async {
      await manager.close();
    });

    test(
      'deleteDatabaseFile closes the connection and deletes the file',
      () async {
        final db = await manager.database;

        await manager.deleteDatabaseFile();

        expect(db.isOpen, isFalse);

        final reopened = await manager.database;
        final tables = await reopened.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table'",
        );
        expect(tables.map((row) => row['name']), contains('databases'));
      },
    );

    test('database reopens after being closed', () async {
      final first = await manager.database;
      await manager.close();

      final second = await manager.database;

      expect(second.isOpen, isTrue);
      expect(identical(first, second), isFalse);
    });
  });

  group('DatabaseRepository', () {
    late DatabaseRepository<Map<String, dynamic>> repository;

    setUp(() {
      repository = DatabaseRepository(tableName: 'databases', manager: manager);
    });

    Map<String, dynamic> row(String id) => {
      'id': id,
      'label': 'Label $id',
      'name': 'name_$id',
      'is_favorite': 0,
      'created_at': '2026-01-01',
      'updated_at': '2026-01-01',
    };

    test('insert and getById round-trip a row', () async {
      await repository.insert(row('1'));

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result!['label'], 'Label 1');
    });

    test('insertAll inserts every row in a single batch', () async {
      await repository.insertAll([row('1'), row('2')]);

      final all = await repository.getAll();

      expect(all, hasLength(2));
    });

    test('insertAll with an empty list is a no-op', () async {
      final result = await repository.insertAll([]);

      expect(result, isEmpty);
    });

    test('getAll respects where and orderBy', () async {
      await repository.insertAll([row('1'), row('2')]);

      final result = await repository.getAll(
        where: 'id = ?',
        whereArgs: ['2'],
      );

      expect(result, hasLength(1));
      expect(result.first['id'], '2');
    });

    test('getWhere filters by every condition', () async {
      await repository.insertAll([row('1'), row('2')]);

      final result = await repository.getWhere(
        conditions: {'id': '2', 'name': 'name_2'},
      );

      expect(result, hasLength(1));
      expect(result.first['id'], '2');
    });

    test('getById returns null when missing', () async {
      final result = await repository.getById('missing');

      expect(result, isNull);
    });

    test('update modifies the matching row', () async {
      await repository.insert(row('1'));

      final updated = row('1')..['label'] = 'Updated';
      await repository.update(updated);

      final result = await repository.getById('1');

      expect(result!['label'], 'Updated');
    });

    test('updateAll with an empty list is a no-op', () async {
      final result = await repository.updateAll([]);

      expect(result, isEmpty);
    });

    test('updateAll updates every row in a single batch', () async {
      await repository.insertAll([row('1'), row('2')]);

      final updated = [
        row('1')..['label'] = 'A',
        row('2')..['label'] = 'B',
      ];
      await repository.updateAll(updated);

      final all = await repository.getAll(orderBy: 'id');

      expect(all[0]['label'], 'A');
      expect(all[1]['label'], 'B');
    });

    test('deleteById removes the matching row', () async {
      await repository.insert(row('1'));

      final count = await repository.deleteById('1');

      expect(count, 1);
      expect(await repository.getById('1'), isNull);
    });

    test('delete removes the row identified by the map id', () async {
      await repository.insert(row('1'));

      final count = await repository.delete(row('1'));

      expect(count, 1);
    });

    test('clear removes every row', () async {
      await repository.insertAll([row('1'), row('2')]);

      await repository.clear();

      expect(await repository.getAll(), isEmpty);
    });

    test('dropTable drops the table', () async {
      await repository.dropTable('databases');

      final db = await manager.database;
      final tables = await db.rawQuery(
        'SELECT name FROM sqlite_master '
        "WHERE type='table' AND name='databases'",
      );

      expect(tables, isEmpty);
    });

    test('dropDatabaseFile deletes the named database file', () async {
      const dbName = 'drop_database_file_test';
      final dbPath = await getDatabasesPath();
      final path = '$dbPath/$dbName.db';
      final db = await openDatabase(path);
      await db.close();

      await repository.dropDatabaseFile(dbName);

      expect(await databaseFactory.databaseExists(path), isFalse);
    });
  });
}
