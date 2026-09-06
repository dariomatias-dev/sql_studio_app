import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';

void main() {
  setUpAll(() {
    Logger.level = Level.off;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late DatabaseManager manager;
  late SqlAdvancedSuggestionsLocalDatasource datasource;

  setUp(() async {
    manager = DatabaseManager();
    await manager.deleteDatabaseFile();
    datasource = SqlAdvancedSuggestionsLocalDatasource(manager);
  });

  tearDown(() async {
    await manager.close();
  });

  Map<String, dynamic> suggestion(String id, int orderIndex) => {
    'id': id,
    'label': 'label $id',
    'code': 'SELECT 1',
    'select_text': null,
    'order_index': orderIndex,
  };

  test('getAll returns rows from sql_advanced_suggestions, ordered', () async {
    await datasource.insertAll([suggestion('b', 1), suggestion('a', 0)]);

    final rows = await datasource.getAll();

    expect(rows.map((r) => r['id']), ['a', 'b']);
  });

  test('insert writes a single row', () async {
    await datasource.insert(suggestion('a', 0));

    final rows = await datasource.getAll();

    expect(rows, hasLength(1));
    expect(rows.single['label'], 'label a');
  });

  test('update replaces an existing row', () async {
    await datasource.insert(suggestion('a', 0));

    final updated = suggestion('a', 0)..['label'] = 'new label';
    await datasource.update(updated);

    final rows = await datasource.getAll();

    expect(rows.single['label'], 'new label');
  });

  test('updateAll replaces multiple rows', () async {
    await datasource.insertAll([suggestion('a', 0), suggestion('b', 1)]);

    await datasource.updateAll([
      suggestion('a', 0)..['label'] = 'a2',
      suggestion('b', 1)..['label'] = 'b2',
    ]);

    final rows = await datasource.getAll();

    expect(rows.map((r) => r['label']), ['a2', 'b2']);
  });

  test('deleteById removes only the matching row', () async {
    await datasource.insertAll([suggestion('a', 0), suggestion('b', 1)]);

    await datasource.deleteById('a');

    final rows = await datasource.getAll();

    expect(rows.map((r) => r['id']), ['b']);
  });

  test('clear removes every row', () async {
    await datasource.insertAll([suggestion('a', 0), suggestion('b', 1)]);

    await datasource.clear();

    expect(await datasource.getAll(), isEmpty);
  });
}
