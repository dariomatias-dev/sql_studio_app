import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/utils/button_style_util.dart';

/// Visual style presets shared by the button widgets.
enum ButtonStyleType {
  /// Solid black background with white text.
  black,

  /// Solid red background with white text, used for destructive actions.
  red,

  /// Colors supplied by the caller, with sensible defaults.
  custom,
}

/// A pill-shaped tap target with a solid background and label text.
class ButtonWidget extends StatelessWidget {
  /// Creates a button with the given [text] and [onPressed] callback.
  const ButtonWidget({
    required this.onPressed,
    required this.text,
    super.key,
    this.style = ButtonStyleType.custom,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.padding,
    this.width,
    this.height = 52.0,
  });

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// Label displayed inside the button.
  final String text;

  /// Visual style preset applied to the button.
  final ButtonStyleType style;

  /// Overrides the background color when [style] is
  /// [ButtonStyleType.custom].
  final Color? backgroundColor;

  /// Overrides the foreground/text color when [style] is
  /// [ButtonStyleType.custom].
  final Color? foregroundColor;

  /// Overrides the border color when [style] is
  /// [ButtonStyleType.custom].
  final Color? borderColor;

  /// Padding applied around the label.
  final EdgeInsetsGeometry? padding;

  /// Fixed width of the button, or `null` to size to content.
  final double? width;

  /// Fixed height of the button.
  final double height;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = resolveButtonStyle(
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
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          highlightColor: Colors.white.withAlpha(20),
          splashColor: Colors.white.withAlpha(20),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: buttonStyle.border),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: buttonStyle.text,
                  fontSize: 15,
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
