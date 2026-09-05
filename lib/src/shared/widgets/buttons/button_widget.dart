import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
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
    this.child,
  });

  /// Called when the button is tapped. When `null`, the button is
  /// disabled.
  final VoidCallback? onPressed;

  /// Label displayed inside the button.
  final String text;

  /// Overrides the default [Text] label, e.g. to show a loading spinner.
  final Widget? child;

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
      colors: context.colors,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
    );

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: buttonStyle.background,
        borderRadius: BorderRadius.circular(AppRadii.full),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadii.full),
          highlightColor: context.colors.white.withAlpha(20),
          splashColor: context.colors.white.withAlpha(20),
          child: Container(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.full),
              border: Border.all(color: buttonStyle.border),
            ),
            child: Center(
              child:
                  child ??
                  Text(
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
