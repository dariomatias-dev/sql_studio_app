import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/services/local_state_service.dart';

import '../../test_helpers/fake_app_logger.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('clear removes preferences and the local database files', () async {
    SharedPreferences.setMockInitialValues({'locale': 'en'});

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('locale'), 'en');

    final temporaryDirectory = Directory.systemTemp.createTempSync(
      'local_state_service_test',
    );
    await databaseFactory.setDatabasesPath(temporaryDirectory.path);

    final dbPath = await getDatabasesPath();
    final directory = Directory(dbPath);
    File('$dbPath/leftover.db').writeAsStringSync('data');

    await LocalStateService(FakeAppLogger()).clear();

    expect((await SharedPreferences.getInstance()).getString('locale'), isNull);
    expect(directory.existsSync(), isFalse);
  });
}
