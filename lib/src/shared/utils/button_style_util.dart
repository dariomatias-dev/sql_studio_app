import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class ButtonStyleData {
  final Color background;
  final Color foreground;
  final Color border;
  final Color text;

  const ButtonStyleData({
    required this.background,
    required this.foreground,
    required this.border,
    required this.text,
  });
}

ButtonStyleData resolveButtonStyle({
  required ButtonStyleType style,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? borderColor,
}) {
  switch (style) {
    case ButtonStyleType.black:
      return ButtonStyleData(
        background: Colors.black,
        foreground: Colors.white,
        border: Colors.black.withAlpha(20),
        text: Colors.white,
      );
    case ButtonStyleType.red:
      return ButtonStyleData(
        background: const Color(0xFFFF3B30),
        foreground: Colors.white,
        border: const Color(0xFFFF3B30).withAlpha(30),
        text: Colors.white,
      );
    case ButtonStyleType.custom:
      return ButtonStyleData(
        background: backgroundColor ?? Colors.white,
        foreground: foregroundColor ?? Colors.black,
        border: borderColor ?? Colors.black.withAlpha(25),
        text: foregroundColor ?? Colors.black,
      );
  }
}
