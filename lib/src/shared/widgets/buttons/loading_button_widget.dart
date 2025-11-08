import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/utils/button_style_util.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class LoadingButtonWidget extends StatefulWidget {
  const LoadingButtonWidget({
    super.key,
    this.onPressed,
    required this.text,
    this.style = ButtonStyleType.custom,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  final Future<void> Function()? onPressed;
  final String text;
  final ButtonStyleType style;
  final Color? backgroundColor;
  final Color? foregroundColor;
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
              height: 18.0,
              width: 18.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: textColor,
              ),
            )
          : Text(widget.text, style: TextStyle(color: textColor)),
    );
  }
}
