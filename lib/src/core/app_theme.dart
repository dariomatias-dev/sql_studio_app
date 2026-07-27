import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// Centralized [ThemeData] for the app, so Material components (text
/// selection, tab indicators, progress indicators, ...) follow
/// [AppColors] instead of Flutter's default purple seed.
class AppTheme {
  AppTheme._();

  static ThemeData _build(AppColors colors, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: colors.black,
            brightness: brightness,
          ).copyWith(
            primary: colors.black,
            secondary: colors.black,
            surface: colors.surface,
            error: colors.error,
          ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.black,
        selectionColor: colors.selection,
        selectionHandleColor: colors.black,
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: colors.black,
        labelColor: colors.black,
        unselectedLabelColor: colors.textMuted,
        dividerColor: colors.border,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.black,
      ),
      extensions: <ThemeExtension<dynamic>>[colors],
    );
  }

  /// The app's light theme.
  static final ThemeData light = _build(AppColors.light, Brightness.light);

  /// The app's dark theme.
  static final ThemeData dark = _build(AppColors.dark, Brightness.dark);
}
