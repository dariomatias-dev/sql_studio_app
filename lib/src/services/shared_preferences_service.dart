import 'package:shared_preferences/shared_preferences.dart';

/// Service class to manage data stored in SharedPreferences.
class SharedPreferencesService {
  /// The SharedPreferences instance.
  static SharedPreferences? _prefs;

  /// Initializes the SharedPreferences instance.
  ///
  /// This method must be called before using any other method.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============== String Operations ==============

  /// Retrieves a String value from SharedPreferences.
  ///
  /// [key] The key to retrieve the String value.
  /// [defaultValue] The default value to return if the key does not exist. Defaults to an empty string.
  ///
  /// Returns the stored String or the [defaultValue] if the key doesn't exist. If the SharedPreferences instance is not initialized, returns the [defaultValue].
  static String getString(
    String key, {
    String defaultValue = '',
  }) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  /// Retrieves a String value from SharedPreferences.
  ///
  /// [key] The key to retrieve the String value.
  ///
  /// Returns the stored String or `null` if the key doesn't exist, or if the SharedPreferences instance is not initialized.
  static String? getStringOrNull(String key) {
    return _prefs?.getString(key);
  }

  /// Saves a String value in SharedPreferences.
  ///
  /// [key] The key to store the String value.
  /// [value] The String value to store.
  ///
  /// Returns the [value] that was stored.
  static Future<String> setString(
    String key,
    String value,
  ) async {
    await _prefs?.setString(key, value);

    return value;
  }

  // ============== Boolean Operations ==============

  /// Retrieves a Boolean value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Boolean value.
  /// [defaultValue] The default value to return if the key does not exist. Defaults to false.
  ///
  /// Returns the stored Boolean or the [defaultValue] if the key doesn't exist. If the SharedPreferences instance is not initialized, returns the [defaultValue].
  static bool getBool(
    String key, {
    bool defaultValue = false,
  }) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  /// Retrieves a Boolean value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Boolean value.
  ///
  /// Returns the stored Boolean or `null` if the key doesn't exist, or if the SharedPreferences instance is not initialized.
  static bool? getBoolOrNull(String key) {
    return _prefs?.getBool(key);
  }

  /// Saves a Boolean value in SharedPreferences.
  ///
  /// [key] The key to store the Boolean value.
  /// [value] The Boolean value to store.
  ///
  /// Returns the [value] that was stored.
  static Future<bool> setBool(
    String key,
    bool value,
  ) async {
    await _prefs?.setBool(key, value);

    return value;
  }

  // ============== String List Operations ==============

  /// Retrieves a List<String> value from SharedPreferences.
  ///
  /// [key] The key to retrieve the list of Strings.
  /// [defaultValue] The default value to return if the key does not exist. Defaults to an empty list.
  ///
  /// Returns the stored List<String> or the [defaultValue] if the key doesn't exist. If the SharedPreferences instance is not initialized, returns the [defaultValue].
  static List<String> getStringList(
    String key, {
    List<String>? defaultValue,
  }) {
    defaultValue ??= <String>[];
    return _prefs?.getStringList(key) ?? defaultValue;
  }

  /// Retrieves a List<String> value from SharedPreferences.
  ///
  /// [key] The key to retrieve the list of Strings.
  ///
  /// Returns the stored List<String> or `null` if the key doesn't exist, or if the SharedPreferences instance is not initialized.
  static List<String>? getStringListOrNull(String key) {
    return _prefs?.getStringList(key);
  }

  /// Saves a List<String> value in SharedPreferences.
  ///
  /// [key] The key to store the list of Strings.
  /// [value] The List<String> value to store.
  ///
  /// Returns the [value] that was stored.
  static Future<List<String>> setStringList(
    String key,
    List<String> value,
  ) async {
    await _prefs?.setStringList(key, value);

    return value;
  }

  // ============== Remove Data ==============

  /// Removes a value associated with the given key from SharedPreferences.
  ///
  /// [key] The key whose value should be removed.
  ///
  /// Returns `true` if the value was successfully removed, otherwise returns `false`.
  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  // ============== Clear Data ==============

  /// Clears all data stored in SharedPreferences.
  ///
  /// Returns `true` if all data was successfully erased, otherwise returns `false`.
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }
}
