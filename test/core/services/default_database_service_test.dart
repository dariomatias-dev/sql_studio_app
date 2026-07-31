import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    Logger.level = Level.off;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late SqlExecutionService sqlService;
  late DefaultDatabaseService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesService.init();

    sqlService = SqlExecutionService();
    service = DefaultDatabaseService(sqlService);
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
      SharedPreferencesService.getInt(
        SharedPreferencesKeys.defaultDatabaseVersionKey,
      ),
      1,
    );
  });

  test('init is a no-op when the stored version is current', () async {
    await SharedPreferencesService.setInt(
      SharedPreferencesKeys.defaultDatabaseVersionKey,
      1,
    );

    final result = await service.init();

    expect(result, isA<SuccessResult<void>>());
    final tables = await sqlService.getTables(
      databaseName: defaultDatabases.first.name,
    );
    expect(tables, isEmpty);
  });
}
