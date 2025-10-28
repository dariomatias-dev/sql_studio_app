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
      return const ButtonStyleData(
        background: Colors.black,
        foreground: Colors.white,
        border: Colors.black,
        text: Colors.white,
      );
    case ButtonStyleType.red:
      return const ButtonStyleData(
        background: Colors.red,
        foreground: Colors.white,
        border: Colors.red,
        text: Colors.white,
      );
    default:
      return ButtonStyleData(
        background: backgroundColor ?? Colors.white,
        foreground: foregroundColor ?? Colors.black,
        border: borderColor ?? Colors.grey,
        text: foregroundColor ?? Colors.black,
      );
  }
}
