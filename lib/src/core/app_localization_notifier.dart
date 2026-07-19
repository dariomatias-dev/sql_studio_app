import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

/// Tracks the app's active locale and persists changes to it.
class AppLocalizationNotifier extends ChangeNotifier {
  /// Creates the notifier and loads the previously persisted locale.
  AppLocalizationNotifier() {
    loadLocale();
  }

  Locale _locale = const Locale('en');

  /// The currently active locale.
  Locale get locale => _locale;

  /// Loads the persisted locale from shared preferences, defaulting to
  /// English when none is stored.
  void loadLocale() {
    final code = SharedPreferencesService.getString(
      SharedPreferencesKeys.localeKey,
      defaultValue: 'en',
    );

    _locale = Locale(code);

    notifyListeners();
  }

  /// Changes the active locale to [code] and persists the choice.
  Future<void> changeLocale(String code) async {
    _locale = Locale(code);

    await SharedPreferencesService.setString(
      SharedPreferencesKeys.localeKey,
      code,
    );

    notifyListeners();
  }
}
