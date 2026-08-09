import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

void main() {
  late SharedPreferencesService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    service = SharedPreferencesService(await SharedPreferences.getInstance());
  });

  test('String get/set round-trip', () async {
    expect(await service.setString('k', 'v'), 'v');

    expect(service.getString('k'), 'v');
    expect(service.getStringOrNull('k'), 'v');
    expect(service.getStringOrNull('missing'), isNull);
    expect(service.getString('missing'), '');
    expect(service.getString('missing', defaultValue: 'd'), 'd');
  });

  test('Bool get/set round-trip', () async {
    expect(await service.setBool('k', value: true), isTrue);

    expect(service.getBool('k'), isTrue);
    expect(service.getBoolOrNull('k'), isTrue);
    expect(service.getBoolOrNull('missing'), isNull);
    expect(service.getBool('missing'), isFalse);
    expect(service.getBool('missing', defaultValue: true), isTrue);
  });

  test('Int get/set round-trip', () async {
    expect(await service.setInt('k', 42), 42);

    expect(service.getInt('k'), 42);
    expect(service.getIntOrNull('k'), 42);
    expect(service.getIntOrNull('missing'), isNull);
    expect(service.getInt('missing'), 0);
    expect(service.getInt('missing', defaultValue: 5), 5);
  });

  test('String list get/set round-trip', () async {
    expect(await service.setStringList('k', ['a', 'b']), ['a', 'b']);

    expect(service.getStringList('k'), ['a', 'b']);
    expect(service.getStringListOrNull('k'), ['a', 'b']);
    expect(service.getStringListOrNull('missing'), isNull);
    expect(service.getStringList('missing'), isEmpty);
    expect(service.getStringList('missing', defaultValue: ['x']), ['x']);
  });

  test('remove deletes the key', () async {
    await service.setString('k', 'v');

    expect(await service.remove('k'), isTrue);
    expect(service.getStringOrNull('k'), isNull);
  });

  test('clear erases every stored key', () async {
    await service.setString('a', '1');
    await service.setString('b', '2');

    expect(await service.clear(), isTrue);
    expect(service.getStringOrNull('a'), isNull);
    expect(service.getStringOrNull('b'), isNull);
  });
}
