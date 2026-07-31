import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('before init', () {
    test('getters return their default value', () {
      expect(SharedPreferencesService.getString('key'), '');
      expect(SharedPreferencesService.getString('key', defaultValue: 'd'), 'd');
      expect(SharedPreferencesService.getStringOrNull('key'), isNull);
      expect(SharedPreferencesService.getBool('key'), isFalse);
      expect(
        SharedPreferencesService.getBool('key', defaultValue: true),
        isTrue,
      );
      expect(SharedPreferencesService.getBoolOrNull('key'), isNull);
      expect(SharedPreferencesService.getInt('key'), 0);
      expect(SharedPreferencesService.getInt('key', defaultValue: 5), 5);
      expect(SharedPreferencesService.getIntOrNull('key'), isNull);
      expect(SharedPreferencesService.getStringList('key'), isEmpty);
      expect(SharedPreferencesService.getStringListOrNull('key'), isNull);
    });
  });

  group('after init', () {
    setUp(() async {
      await SharedPreferencesService.init();
    });

    test('String get/set round-trip', () async {
      expect(await SharedPreferencesService.setString('k', 'v'), 'v');

      expect(SharedPreferencesService.getString('k'), 'v');
      expect(SharedPreferencesService.getStringOrNull('k'), 'v');
      expect(SharedPreferencesService.getStringOrNull('missing'), isNull);
    });

    test('Bool get/set round-trip', () async {
      expect(await SharedPreferencesService.setBool('k', value: true), isTrue);

      expect(SharedPreferencesService.getBool('k'), isTrue);
      expect(SharedPreferencesService.getBoolOrNull('k'), isTrue);
      expect(SharedPreferencesService.getBoolOrNull('missing'), isNull);
    });

    test('Int get/set round-trip', () async {
      expect(await SharedPreferencesService.setInt('k', 42), 42);

      expect(SharedPreferencesService.getInt('k'), 42);
      expect(SharedPreferencesService.getIntOrNull('k'), 42);
      expect(SharedPreferencesService.getIntOrNull('missing'), isNull);
    });

    test('String list get/set round-trip', () async {
      expect(
        await SharedPreferencesService.setStringList('k', ['a', 'b']),
        ['a', 'b'],
      );

      expect(SharedPreferencesService.getStringList('k'), ['a', 'b']);
      expect(SharedPreferencesService.getStringListOrNull('k'), ['a', 'b']);
      expect(SharedPreferencesService.getStringListOrNull('missing'), isNull);
      expect(
        SharedPreferencesService.getStringList('missing', defaultValue: ['x']),
        ['x'],
      );
    });

    test('remove deletes the key', () async {
      await SharedPreferencesService.setString('k', 'v');

      expect(await SharedPreferencesService.remove('k'), isTrue);
      expect(SharedPreferencesService.getStringOrNull('k'), isNull);
    });

    test('clear erases every stored key', () async {
      await SharedPreferencesService.setString('a', '1');
      await SharedPreferencesService.setString('b', '2');

      expect(await SharedPreferencesService.clear(), isTrue);
      expect(SharedPreferencesService.getStringOrNull('a'), isNull);
      expect(SharedPreferencesService.getStringOrNull('b'), isNull);
    });
  });
}
