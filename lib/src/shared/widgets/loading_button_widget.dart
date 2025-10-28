import 'package:flutter/material.dart';

enum ButtonStyleType { black, red, custom }

class LoadingButtonWidget extends StatefulWidget {
  const LoadingButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.style = ButtonStyleType.custom,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  final Future<void> Function() onPressed;
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
    await widget.onPressed();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    late final Color bd;
    late final Color tx;

    switch (widget.style) {
      case ButtonStyleType.black:
        bg = Colors.black;
        fg = Colors.white;
        bd = Colors.black;
        tx = Colors.white;
        break;
      case ButtonStyleType.red:
        bg = Colors.red;
        fg = Colors.white;
        bd = Colors.red;
        tx = Colors.white;
        break;
      default:
        bg = widget.backgroundColor ?? Colors.white;
        fg = widget.foregroundColor ?? Colors.black;
        bd = widget.borderColor ?? Colors.grey;
        tx = fg == Colors.white ? Colors.black : fg;
    }

    return ElevatedButton(
      onPressed: _loading ? null : _handlePress,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => bg),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) => tx),
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (states) => Colors.transparent,
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => BorderSide(color: bd),
        ),
      ),
      child: _loading
          ? SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: tx),
            )
          : Text(widget.text, style: TextStyle(color: tx)),
    );
  }
}
