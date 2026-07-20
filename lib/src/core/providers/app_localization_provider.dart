import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Tracks the app's active locale and persists changes to it.
class AppLocalizationViewModel extends Notifier<Locale> {
  @override
  Locale build() {
    final code = SharedPreferencesService.getString(
      SharedPreferencesKeys.localeKey,
      defaultValue: 'en',
    );

    return Locale(code);
  }

  /// Changes the active locale to [code] and persists the choice.
  Future<void> changeLocale(String code) async {
    state = Locale(code);

    await SharedPreferencesService.setString(
      SharedPreferencesKeys.localeKey,
      code,
    );
  }
}

/// Exposes the [AppLocalizationViewModel] and the active [Locale].
final NotifierProvider<AppLocalizationViewModel, Locale>
appLocalizationViewModelProvider = NotifierProvider(
  AppLocalizationViewModel.new,
);
