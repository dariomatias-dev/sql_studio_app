import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/utils/button_style_util.dart';

enum ButtonStyleType { black, red, custom }

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final ButtonStyleType style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double height;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.style = ButtonStyleType.custom,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.padding,
    this.width,
    this.height = 52.0,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyleData buttonStyle = resolveButtonStyle(
      style: style,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
    );

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: buttonStyle.background,
        borderRadius: BorderRadius.circular(32.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32.0),
          highlightColor: Colors.white.withAlpha(20),
          splashColor: Colors.white.withAlpha(20),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(color: buttonStyle.border, width: 1.0),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: buttonStyle.text,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
