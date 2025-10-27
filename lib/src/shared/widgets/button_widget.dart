import 'package:flutter/material.dart';

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
    late final Color bg;
    late final Color fg;
    late final Color bd;

    switch (style) {
      case ButtonStyleType.black:
        bg = Colors.black;
        fg = Colors.white;
        bd = Colors.black;
        break;
      case ButtonStyleType.red:
        bg = Colors.red;
        fg = Colors.white;
        bd = Colors.red;
        break;
      default:
        bg = backgroundColor ?? Colors.white;
        fg = foregroundColor ?? Colors.black;
        bd = borderColor ?? Colors.grey;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        side: BorderSide(color: bd),
      ),
      child: Text(text),
    );
  }
}
