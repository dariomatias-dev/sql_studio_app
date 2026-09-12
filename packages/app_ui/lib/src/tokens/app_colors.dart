import 'package:flutter/material.dart';

/// Centralized grayscale + semantic palette used across the app.
///
/// Registered as a [ThemeExtension] so widgets read the palette that
/// matches the active [ThemeMode] via `context.colors` instead of a
/// fixed set of constants.
class AppColors extends ThemeExtension<AppColors> {
  /// Creates a palette instance with every semantic color required.
  const AppColors({
    required this.black,
    required this.white,
    required this.transparent,
    required this.black87,
    required this.black54,
    required this.background,
    required this.textPrimary,
    required this.surface,
    required this.surfaceMuted,
    required this.border,
    required this.textMuted,
    required this.controlInactive,
    required this.disabled,
    required this.selection,
    required this.error,
  });

  /// High-emphasis brand color: primary text, icons, and brand-filled
  /// surfaces like buttons, headers, and active nav indicators.
  final Color black;

  /// Text and icons on top of [black]-filled surfaces.
  final Color white;

  /// Fully transparent, used to animate a fill in/out.
  final Color transparent;

  /// High-emphasis text/icons over [surface], one step softer than [black].
  final Color black87;

  /// Medium-emphasis secondary text/icons.
  final Color black54;

  /// Page/scaffold background and neutral fills.
  final Color background;

  /// Primary text and iconography.
  final Color textPrimary;

  /// Card/panel surface, sits on top of [background].
  final Color surface;

  /// Barely-tinted surface for selected/active card variants.
  final Color surfaceMuted;

  /// Hairline borders and dividers.
  final Color border;

  /// Muted secondary text and icons.
  final Color textMuted;

  /// Drag handles and inactive control fills — one step stronger than
  /// [border] for elements that need to read as interactive/structural.
  final Color controlInactive;

  /// Faded/de-emphasized lines and disabled fills.
  final Color disabled;

  /// Text selection highlight.
  final Color selection;

  /// Destructive actions and validation errors.
  final Color error;

  /// The app's light palette.
  static const light = AppColors(
    black: Colors.black,
    white: Colors.white,
    transparent: Colors.transparent,
    black87: Colors.black87,
    black54: Colors.black54,
    background: Color(0xFFF2F2F2),
    textPrimary: Color(0xFF111111),
    surface: Colors.white,
    surfaceMuted: Color(0xFFFBFBFB),
    border: Color(0xFFEEEEEE),
    textMuted: Color(0xFF757575),
    controlInactive: Color(0xFFADADAD),
    disabled: Color(0xFFDADADA),
    selection: Color(0x334D4D4D),
    error: Color(0xFFFF3B30),
  );

  /// The app's dark palette.
  static const dark = AppColors(
    black: Colors.white,
    white: Colors.black,
    transparent: Colors.transparent,
    black87: Colors.white,
    black54: Colors.white60,
    background: Color(0xFF121212),
    textPrimary: Color(0xFFF5F5F5),
    surface: Color(0xFF1E1E1E),
    surfaceMuted: Color(0xFF262626),
    border: Color(0xFF2E2E2E),
    textMuted: Color(0xFFAAAAAA),
    controlInactive: Color(0xFF5C5C5C),
    disabled: Color(0xFF3A3A3A),
    selection: Color(0x33FFFFFF),
    error: Color(0xFFFF453A),
  );

  @override
  AppColors copyWith({
    Color? black,
    Color? white,
    Color? transparent,
    Color? black87,
    Color? black54,
    Color? background,
    Color? textPrimary,
    Color? surface,
    Color? surfaceMuted,
    Color? border,
    Color? textMuted,
    Color? controlInactive,
    Color? disabled,
    Color? selection,
    Color? error,
  }) {
    return AppColors(
      black: black ?? this.black,
      white: white ?? this.white,
      transparent: transparent ?? this.transparent,
      black87: black87 ?? this.black87,
      black54: black54 ?? this.black54,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      textMuted: textMuted ?? this.textMuted,
      controlInactive: controlInactive ?? this.controlInactive,
      disabled: disabled ?? this.disabled,
      selection: selection ?? this.selection,
      error: error ?? this.error,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      black: Color.lerp(black, other.black, t)!,
      white: Color.lerp(white, other.white, t)!,
      transparent: Color.lerp(transparent, other.transparent, t)!,
      black87: Color.lerp(black87, other.black87, t)!,
      black54: Color.lerp(black54, other.black54, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      controlInactive: Color.lerp(
        controlInactive,
        other.controlInactive,
        t,
      )!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      selection: Color.lerp(selection, other.selection, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
