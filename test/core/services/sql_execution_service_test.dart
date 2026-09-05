import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';

import '../../test_helpers/fake_app_logger.dart';

class _RecordingAppLogger implements AppLogger {
  final messages = <String>[];
  final errors = <Object?>[];

  @override
  void info(String message) => messages.add(message);

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    messages.add(message);
    errors.add(error);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    messages.add(message);
    errors.add(error);
  }
}

void main() {
  setUpAll(() {
    Logger.level = Level.off;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late String dbName;
  late SqlExecutionService service;

  setUp(() {
    dbName = 'test_db_${DateTime.now().microsecondsSinceEpoch}';
    service = SqlExecutionService(FakeAppLogger());
  });

  tearDown(() async {
    final dbPath = await getDatabasesPath();
    await databaseFactory.deleteDatabase('$dbPath/$dbName.db');
  });

  test('returns noDatabaseSelected when databaseName is null', () async {
    final result = await service.execute(sql: 'SELECT 1', databaseName: null);

    expect(result, isA<FailureResult<DatabaseSuccess?>>());
    expect(
      (result as FailureResult<DatabaseSuccess?>).error.type,
      AppLocalizationsKey.noDatabaseSelected,
    );
  });

  test('returns noDatabaseSelected when databaseName is empty', () async {
    final result = await service.execute(sql: 'SELECT 1', databaseName: '');

    expect(result, isA<FailureResult<DatabaseSuccess?>>());
  });

  test('runs a DDL statement and reports statementSuccess', () async {
    final result = await service.execute(
      sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.type, AppLocalizationsKey.statementSuccess);
  });

  test('runs an INSERT and reports insertSuccess with the new id', () async {
    await service.execute(
      sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
      databaseName: dbName,
    );

    final result = await service.execute(
      sql: "INSERT INTO users (name) VALUES ('alice')",
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.type, AppLocalizationsKey.insertSuccess);
    expect(success.args['id'], 1);
  });

  test('runs a SELECT and returns the matching rows', () async {
    await service.execute(
      sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
      databaseName: dbName,
    );
    await service.execute(
      sql: "INSERT INTO users (name) VALUES ('alice')",
      databaseName: dbName,
    );

    final result = await service.execute(
      sql: 'SELECT name FROM users',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.result, [
      {'name': 'alice'},
    ]);
  });

  test('runs an UPDATE and reports the affected row count', () async {
    await service.execute(
      sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
      databaseName: dbName,
    );
    await service.execute(
      sql: "INSERT INTO users (name) VALUES ('alice')",
      databaseName: dbName,
    );

    final result = await service.execute(
      sql: "UPDATE users SET name = 'bob'",
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.type, AppLocalizationsKey.updateSuccess);
    expect(success.args['count'], 1);
  });

  test('runs a DELETE and reports the affected row count', () async {
    await service.execute(
      sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
      databaseName: dbName,
    );
    await service.execute(
      sql: "INSERT INTO users (name) VALUES ('alice')",
      databaseName: dbName,
    );

    final result = await service.execute(
      sql: 'DELETE FROM users',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.type, AppLocalizationsKey.deleteSuccess);
    expect(success.args['count'], 1);
  });

  test('runs multiple semicolon-separated statements in order', () async {
    final result = await service.execute(
      sql: '''
        CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);
        INSERT INTO users (name) VALUES ('alice');
        INSERT INTO users (name) VALUES ('bob');
      ''',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.type, AppLocalizationsKey.insertSuccess);
    expect(success.args['id'], 2);

    final selectResult = await service.execute(
      sql: 'SELECT name FROM users ORDER BY id',
      databaseName: dbName,
    );
    final selectSuccess =
        (selectResult as SuccessResult<DatabaseSuccess?>).value!;
    expect(selectSuccess.result, [
      {'name': 'alice'},
      {'name': 'bob'},
    ]);
  });

  test('does not split on a semicolon inside a string literal', () async {
    await service.execute(
      sql: 'CREATE TABLE notes (id INTEGER PRIMARY KEY, text TEXT)',
      databaseName: dbName,
    );

    await service.execute(
      sql: "INSERT INTO notes (text) VALUES ('a;b')",
      databaseName: dbName,
    );

    final result = await service.execute(
      sql: 'SELECT text FROM notes',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.result, [
      {'text': 'a;b'},
    ]);
  });

  test('does not split on a semicolon inside a line comment', () async {
    final result = await service.execute(
      sql: '''
        SELECT 1; -- note: uses ; here
        SELECT 2;
      ''',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.result, [
      {'2': 2},
    ]);
  });

  test('does not split on a semicolon inside a block comment', () async {
    final result = await service.execute(
      sql: '''
        SELECT 1; /* note: uses ; here */
        SELECT 2;
      ''',
      databaseName: dbName,
    );

    final success = (result as SuccessResult<DatabaseSuccess?>).value!;
    expect(success.result, [
      {'2': 2},
    ]);
  });

  test(
    'does not split on semicolons inside a trigger BEGIN...END block',
    () async {
      await service.execute(
        sql: '''
          CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);
          CREATE TABLE audit (id INTEGER PRIMARY KEY, action TEXT);
        ''',
        databaseName: dbName,
      );

      final result = await service.execute(
        sql: '''
          CREATE TRIGGER users_ai AFTER INSERT ON users
          BEGIN
            INSERT INTO audit (action) VALUES ('insert');
          END;
        ''',
        databaseName: dbName,
      );

      final success = (result as SuccessResult<DatabaseSuccess?>).value!;
      expect(success.type, AppLocalizationsKey.statementSuccess);

      await service.execute(
        sql: "INSERT INTO users (name) VALUES ('alice')",
        databaseName: dbName,
      );

      final auditResult = await service.execute(
        sql: 'SELECT action FROM audit',
        databaseName: dbName,
      );
      final auditSuccess =
          (auditResult as SuccessResult<DatabaseSuccess?>).value!;
      expect(auditSuccess.result, [
        {'action': 'insert'},
      ]);
    },
  );

  test('returns sqlExecutionError when the SQL is invalid', () async {
    final result = await service.execute(
      sql: 'SELECT * FROM nonexistent_table',
      databaseName: dbName,
    );

    expect(result, isA<FailureResult<DatabaseSuccess?>>());
    expect(
      (result as FailureResult<DatabaseSuccess?>).error.type,
      AppLocalizationsKey.sqlExecutionError,
    );
  });

  test('getTableColumns returns the column names of a table', () async {
    await service.execute(
      sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
      databaseName: dbName,
    );

    final columns = await service.getTableColumns(
      databaseName: dbName,
      tableName: 'users',
    );

    expect(columns, ['id', 'name']);
  });

  test(
    'getDatabaseStructure returns tables, columns and foreign keys',
    () async {
      await service.execute(
        sql: '''
          CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);
          CREATE TABLE books (
            id INTEGER PRIMARY KEY,
            title TEXT,
            author_id INTEGER,
            FOREIGN KEY (author_id) REFERENCES authors (id)
          );
        ''',
        databaseName: dbName,
      );

      final structure = await service.getDatabaseStructure(
        databaseName: dbName,
      );

      final books = structure.firstWhere((table) => table.name == 'books');
      final authorIdColumn = books.columns.firstWhere(
        (col) => col.name == 'author_id',
      );

      expect(authorIdColumn.foreignTable, 'authors');
      expect(authorIdColumn.foreignColumn, 'id');
    },
  );

  test('closeAll closes every cached connection', () async {
    final otherDbName = '${dbName}_other';

    await service.execute(
      sql: 'CREATE TABLE a (id INTEGER)',
      databaseName: dbName,
    );
    await service.execute(
      sql: 'CREATE TABLE b (id INTEGER)',
      databaseName: otherDbName,
    );

    final dbPath = await getDatabasesPath();
    final first = await databaseFactory.openDatabase('$dbPath/$dbName.db');
    final second = await databaseFactory.openDatabase(
      '$dbPath/$otherDbName.db',
    );

    await service.closeAll();

    expect(first.isOpen, isFalse);
    expect(second.isOpen, isFalse);

    await databaseFactory.deleteDatabase('$dbPath/$otherDbName.db');
  });

  test('closeAll reopens a database on the next execute', () async {
    await service.execute(
      sql: 'CREATE TABLE a (id INTEGER)',
      databaseName: dbName,
    );
    await service.closeAll();

    final result = await service.execute(
      sql: 'INSERT INTO a (id) VALUES (1)',
      databaseName: dbName,
    );

    expect(result, isA<SuccessResult<DatabaseSuccess?>>());
  });

  group('logging', () {
    late _RecordingAppLogger logger;
    late SqlExecutionService loggingService;

    setUp(() {
      logger = _RecordingAppLogger();
      loggingService = SqlExecutionService(logger);
    });

    test('never records the statement text or the database name', () async {
      await loggingService.execute(
        sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY, secret TEXT)',
        databaseName: dbName,
      );
      await loggingService.execute(
        sql: "INSERT INTO users (secret) VALUES ('hunter2')",
        databaseName: dbName,
      );
      await loggingService.execute(
        sql: 'SELECT * FROM users',
        databaseName: dbName,
      );
      await loggingService.execute(
        sql: "UPDATE users SET secret = 'other'",
        databaseName: dbName,
      );
      await loggingService.execute(
        sql: 'DELETE FROM users',
        databaseName: dbName,
      );
      await loggingService.closeAll();

      expect(logger.messages, isNotEmpty);

      for (final message in logger.messages) {
        expect(message, isNot(contains('hunter2')));
        expect(message, isNot(contains('users')));
        expect(message, isNot(contains(dbName)));
      }
    });

    test('reports row counts instead of the statement', () async {
      await loggingService.execute(
        sql: 'CREATE TABLE users (id INTEGER PRIMARY KEY)',
        databaseName: dbName,
      );
      await loggingService.execute(
        sql: 'INSERT INTO users (id) VALUES (1)',
        databaseName: dbName,
      );
      await loggingService.execute(
        sql: 'DELETE FROM users',
        databaseName: dbName,
      );
      await loggingService.closeAll();

      expect(logger.messages, contains('Executed statement'));
      expect(logger.messages, contains('Executed INSERT'));
      expect(logger.messages, contains('Executed DELETE: 1 rows'));
    });

    /// The raw error carries the failing SQL, so it is attached only in
    /// debug builds; this runs in one, hence the attached error here.
    test('records a failure without the statement in the message', () async {
      await loggingService.execute(
        sql: "SELECT * FROM missing_table WHERE secret = 'hunter2'",
        databaseName: dbName,
      );
      await loggingService.closeAll();

      expect(logger.messages, contains('Failed to execute SQL'));
      expect(logger.errors.last, isNotNull);

      for (final message in logger.messages) {
        expect(message, isNot(contains('hunter2')));
      }
    });
  });

  test('closeAll is a no-op when nothing is cached', () async {
    await expectLater(service.closeAll(), completes);
  });
}
