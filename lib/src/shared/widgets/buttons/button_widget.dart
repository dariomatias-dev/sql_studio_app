import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/utils/button_style_util.dart';

enum ButtonStyleType { black, red, custom }

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.style = ButtonStyleType.custom,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  final VoidCallback onPressed;
  final String text;
  final ButtonStyleType style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = resolveButtonStyle(
      style: style,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonStyle.background,
        foregroundColor: buttonStyle.foreground,
        side: BorderSide(color: buttonStyle.border),
      ),
      child: Text(text, style: TextStyle(color: buttonStyle.text)),
    );
  }
}
