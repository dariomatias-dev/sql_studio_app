import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class AppLocalizationNotifier extends ChangeNotifier {
  AppLocalizationNotifier() {
    loadLocale();
  }

  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void loadLocale() {
    final code = SharedPreferencesService.getString(
      SharedPreferencesKeys.localeKey,
      defaultValue: 'en',
    );

    _locale = Locale(code);

    notifyListeners();
  }

  Future<void> changeLocale(String code) async {
    _locale = Locale(code);

    await SharedPreferencesService.setString(
      SharedPreferencesKeys.localeKey,
      code,
    );

    notifyListeners();
  }
}
