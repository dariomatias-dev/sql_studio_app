import 'package:flutter/material.dart';

/// Centralized grayscale + semantic palette used across the app.
class AppColors {
  AppColors._();

  /// Pure black: primary text, icons, and brand-black surfaces like
  /// buttons, headers, and active nav indicators.
  static const Color black = Colors.black;

  /// Pure white: text and icons on dark surfaces.
  static const Color white = Colors.white;

  /// Fully transparent, used to animate a fill in/out.
  static const Color transparent = Colors.transparent;

  /// Black at 87% opacity, for high-emphasis text/icons over light
  /// surfaces where full opaque black is too heavy.
  static const Color black87 = Colors.black87;

  /// Black at 54% opacity, for medium-emphasis secondary text/icons.
  static const Color black54 = Colors.black54;

  /// Page/scaffold background and neutral fills.
  static const Color background = Color(0xFFF2F2F2);

  /// Primary near-black text and iconography.
  static const Color textPrimary = Color(0xFF111111);

  /// Card/panel surface, sits on top of [background].
  static const Color surface = Colors.white;

  /// Barely-off-white surface for selected/active card variants.
  static const Color surfaceMuted = Color(0xFFFBFBFB);

  /// Hairline borders and dividers.
  static const Color border = Color(0xFFEEEEEE);

  /// Muted secondary text and icons.
  static const Color textMuted = Color(0xFF757575);

  /// Drag handles and inactive control fills — one step darker than
  /// [border] for elements that need to read as interactive/structural.
  static const Color controlInactive = Color(0xFFADADAD);

  /// Faded/de-emphasized lines and disabled fills.
  static const Color disabled = Color(0xFFDADADA);

  /// Text selection highlight.
  static const Color selection = Color(0x334D4D4D);

  /// Destructive actions and validation errors.
  static const Color error = Color(0xFFFF3B30);
}
