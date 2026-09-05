import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';

import '../../test_helpers/shared_preferences_test_helper.dart';

class _MockSqlExecutionService extends Mock implements SqlExecutionService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    Logger.level = Level.off;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late SqlExecutionService sqlService;
  late SharedPreferencesService prefs;
  late DefaultDatabaseService service;

  setUp(() async {
    prefs = await fakeSharedPreferencesService();

    sqlService = SqlExecutionService();
    service = DefaultDatabaseService(sqlService, prefs);
  });

  tearDown(() async {
    for (final dbModel in defaultDatabases) {
      await sqlService.closeDatabase(dbModel.name);

      final dbPath = await getDatabasesPath();
      await databaseFactory.deleteDatabase('$dbPath/${dbModel.name}.db');
    }
  });

  test('execute seeds the schema and data for a single database', () async {
    final dbName = defaultDatabases.first.name;

    final result = await service.execute(dbName);

    expect(result, isA<SuccessResult<void>>());

    final tables = await sqlService.getTables(databaseName: dbName);
    expect(tables, isNotEmpty);
  });

  /// A closed connection means [SqlExecutionService.getTables] must reopen
  /// a fresh handle rather than reuse a stale cached one.
  test('execute closes the connection after running', () async {
    final dbName = defaultDatabases.first.name;

    await service.execute(dbName);

    final tables = await sqlService.getTables(databaseName: dbName);
    expect(tables, isNotEmpty);
  });

  /// `rootBundle.loadString` throws a [FlutterError], not an [Exception],
  /// so it bypasses the service's `on Exception` catch and propagates.
  test('execute throws when the asset for the database is missing', () {
    expect(() => service.execute('does_not_exist'), throwsFlutterError);
  });

  test('init seeds every default database and stores the version', () async {
    final result = await service.init();

    expect(result, isA<SuccessResult<void>>());
    expect(
      prefs.getInt(SharedPreferencesKeys.defaultDatabaseVersionKey),
      1,
    );
  });

  test('init is a no-op when the stored version is current', () async {
    await prefs.setInt(SharedPreferencesKeys.defaultDatabaseVersionKey, 1);

    final result = await service.init();

    expect(result, isA<SuccessResult<void>>());
    final tables = await sqlService.getTables(
      databaseName: defaultDatabases.first.name,
    );
    expect(tables, isEmpty);
  });

  group('when a statement fails', () {
    late _MockSqlExecutionService failingSqlService;
    late DefaultDatabaseService failingService;

    setUp(() {
      failingSqlService = _MockSqlExecutionService();
      failingService = DefaultDatabaseService(failingSqlService, prefs);

      when(
        () => failingSqlService.closeDatabase(any()),
      ).thenAnswer((_) async {});
      when(
        () => failingSqlService.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).thenAnswer(
        (_) async => const FailureResult(
          DatabaseFailure(AppLocalizationsKey.sqlExecutionError, {
            'error': 'boom',
          }),
        ),
      );
    });

    test('execute returns a failure carrying the database name', () async {
      final dbName = defaultDatabases.first.name;

      final result = await failingService.execute(dbName);

      expect(result, isA<FailureResult<void>>());

      final error = (result as FailureResult<void>).error;
      expect(error.type, AppLocalizationsKey.failedToExecuteSql);
      expect(error.args['dbName'], dbName);
      expect(error.args['error'], 'boom');
    });

    test('execute stops at the first failing statement', () async {
      await failingService.execute(defaultDatabases.first.name);

      verify(
        () => failingSqlService.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).called(1);
    });

    test('init leaves the version key unwritten', () async {
      final result = await failingService.init();

      expect(result, isA<FailureResult<void>>());
      expect(
        prefs.getIntOrNull(SharedPreferencesKeys.defaultDatabaseVersionKey),
        isNull,
      );
    });
  });
}
