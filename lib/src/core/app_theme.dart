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
      seedColor: AppColors.black,
    ).copyWith(primary: AppColors.black, secondary: AppColors.black),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
      selectionColor: AppColors.selection,
      selectionHandleColor: AppColors.black,
    ),
    tabBarTheme: const TabBarThemeData(
      indicatorColor: AppColors.black,
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.textMuted,
      dividerColor: AppColors.border,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
    ),
  );
}
