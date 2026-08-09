import 'package:shared_preferences/shared_preferences.dart';

/// Reads and writes app preferences, backed by an already-initialized
/// [SharedPreferences] instance. Shared via DI (see
/// `sharedPreferencesServiceProvider`) rather than constructed ad hoc.
class SharedPreferencesService {
  /// Creates the service backed by an already-resolved [_prefs] instance.
  const SharedPreferencesService(this._prefs);

  /// Resolves the platform [SharedPreferences] instance and wraps it.
  static Future<SharedPreferencesService> create() async {
    return SharedPreferencesService(await SharedPreferences.getInstance());
  }

  final SharedPreferences _prefs;

  // ==================================================
  // ============== String Operations =================
  // ==================================================

  /// Retrieves a String value, or [defaultValue] if the key doesn't exist.
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  /// Retrieves a String value, or `null` if the key doesn't exist.
  String? getStringOrNull(String key) {
    return _prefs.getString(key);
  }

  /// Saves a String [value] and returns it.
  Future<String> setString(String key, String value) async {
    await _prefs.setString(key, value);
    return value;
  }

  // ==================================================
  // ============== Boolean Operations ================
  // ==================================================

  /// Retrieves a Boolean value, or [defaultValue] if the key doesn't exist.
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  /// Retrieves a Boolean value, or `null` if the key doesn't exist.
  bool? getBoolOrNull(String key) {
    return _prefs.getBool(key);
  }

  /// Saves a Boolean [value] and returns it.
  Future<bool> setBool(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
    return value;
  }

  // ==================================================
  // ============== Integer Operations ================
  // ==================================================

  /// Retrieves an Integer value, or [defaultValue] if the key doesn't exist.
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  /// Retrieves an Integer value, or `null` if the key doesn't exist.
  int? getIntOrNull(String key) {
    return _prefs.getInt(key);
  }

  /// Saves an Integer [value] and returns it.
  Future<int> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
    return value;
  }

  // ==================================================
  // ============== String List Operations ============
  // ==================================================

  /// Retrieves a List&lt;String&gt; value, or [defaultValue] if the key
  /// doesn't exist.
  List<String> getStringList(String key, {List<String>? defaultValue}) {
    defaultValue ??= <String>[];
    return _prefs.getStringList(key) ?? defaultValue;
  }

  /// Retrieves a List&lt;String&gt; value, or `null` if the key doesn't
  /// exist.
  List<String>? getStringListOrNull(String key) {
    return _prefs.getStringList(key);
  }

  /// Saves a List&lt;String&gt; [value] and returns it.
  Future<List<String>> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
    return value;
  }

  // ==================================================
  // ============== Remove Data =======================
  // ==================================================

  /// Removes the value associated with [key], returning whether it
  /// succeeded.
  Future<bool> remove(String key) => _prefs.remove(key);

  // ==================================================
  // ============== Clear Data ========================
  // ==================================================

  /// Clears all data, returning whether it succeeded.
  Future<bool> clear() => _prefs.clear();
}
