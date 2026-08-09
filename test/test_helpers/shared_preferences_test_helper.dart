import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Seeds mock `SharedPreferences` values and wraps them in a
/// [SharedPreferencesService], for overriding
/// `sharedPreferencesServiceProvider` in tests.
Future<SharedPreferencesService> fakeSharedPreferencesService([
  Map<String, Object> values = const {},
]) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();

  return SharedPreferencesService(prefs);
}
