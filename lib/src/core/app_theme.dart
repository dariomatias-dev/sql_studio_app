import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// Centralized [ThemeData] for the app, so Material components (text
/// selection, tab indicators, progress indicators, ...) follow
/// [AppColors] instead of Flutter's default purple seed.
class AppTheme {
  AppTheme._();

  /// The app's single (light) theme.
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
    ).copyWith(primary: Colors.black, secondary: Colors.black),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Color(0x334D4D4D),
      selectionHandleColor: Colors.black,
    ),
    tabBarTheme: const TabBarThemeData(
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      unselectedLabelColor: AppColors.textMuted,
      dividerColor: AppColors.border,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.black,
    ),
  );
}
