import 'package:flutter/material.dart';

/// Centralized grayscale + semantic palette used across the app.
class AppColors {
  AppColors._();

  /// Page/scaffold background and neutral fills.
  static const Color background = Color(0xFFF2F2F2);

  /// Primary near-black text and iconography.
  static const Color textPrimary = Color(0xFF111111);

  /// Card/panel surface, sits on top of [background].
  static const Color surface = Colors.white;

  /// Hairline borders and dividers.
  static const Color border = Color(0xFFEEEEEE);

  /// Muted secondary text and icons.
  static const Color textMuted = Color(0xFF757575);

  /// Drag handles and inactive control fills — one step darker than
  /// [border] for elements that need to read as interactive/structural.
  static const Color controlInactive = Color(0xFFADADAD);

  /// Destructive actions and validation errors.
  static const Color error = Color(0xFFFF3B30);
}
