import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Tracks the app's active [ThemeMode] and persists changes to it.
class AppThemeModeViewModel extends Notifier<ThemeMode> {
  late final SharedPreferencesService _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.read(sharedPreferencesServiceProvider);

    final name = _prefs.getString(
      SharedPreferencesKeys.themeModeKey,
      defaultValue: ThemeMode.system.name,
    );

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  /// Changes the active theme mode to [mode] and persists the choice.
  Future<void> changeThemeMode(ThemeMode mode) async {
    state = mode;

    await _prefs.setString(SharedPreferencesKeys.themeModeKey, mode.name);
  }
}

/// Exposes the [AppThemeModeViewModel] and the active [ThemeMode].
final NotifierProvider<AppThemeModeViewModel, ThemeMode>
appThemeModeViewModelProvider = NotifierProvider(
  AppThemeModeViewModel.new,
);
