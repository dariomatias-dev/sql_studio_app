import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/utils/button_style_util.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

/// A button that shows a spinner and disables itself while its
/// asynchronous [onPressed] callback is running.
class LoadingButtonWidget extends StatefulWidget {
  /// Creates a loading button with the given [text] and [onPressed]
  /// callback.
  const LoadingButtonWidget({
    required this.text,
    super.key,
    this.onPressed,
    this.style = ButtonStyleType.custom,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  /// Called when the button is tapped. While it resolves, the button
  /// shows a spinner and further taps are ignored.
  final Future<void> Function()? onPressed;

  /// Label displayed when not loading.
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

  @override
  State<LoadingButtonWidget> createState() => _LoadingButtonWidgetState();
}

class _LoadingButtonWidgetState extends State<LoadingButtonWidget> {
  bool _loading = false;

  Future<void> _handlePress() async {
    if (_loading) return;

    setState(() => _loading = true);

    await widget.onPressed!();

    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = resolveButtonStyle(
      style: widget.style,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      borderColor: widget.borderColor,
    );

    final isDisabled = widget.onPressed == null || _loading;

    final background = isDisabled
        ? buttonStyle.background.withAlpha(30)
        : buttonStyle.background;

    final borderColor = isDisabled
        ? buttonStyle.border.withAlpha(0)
        : buttonStyle.border;

    final textColor = buttonStyle.text;

    return ElevatedButton(
      onPressed: isDisabled ? null : _handlePress,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(background),
        foregroundColor: WidgetStateProperty.all<Color>(textColor),
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: borderColor),
        ),
      ),
      child: _loading
          ? SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )
          : Text(widget.text, style: TextStyle(color: textColor)),
    );
  }
}
