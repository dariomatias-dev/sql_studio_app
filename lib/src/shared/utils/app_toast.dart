import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sql_studio/main.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';

/// Shows short, transient feedback messages with the app's single,
/// consistent toast style.
class AppToast {
  const AppToast._();

  /// Shows [message] in a toast styled consistently across the app,
  /// flipping to a white chip in dark mode so it stays legible.
  static Future<void> show(String message) {
    final themeMode = appProviderContainer.read(appThemeModeViewModelProvider);
    final isDark = switch (themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark,
    };

    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: isDark ? Colors.white : Colors.black,
      textColor: isDark ? Colors.black : Colors.white,
      fontSize: 14,
    );
  }
}
