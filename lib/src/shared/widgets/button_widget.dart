import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.borderColor = Colors.grey,
  });

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 2.0,
        shadowColor: Colors.black.withAlpha(26),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: BorderSide(color: borderColor, width: 1.0),
        ),
        textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
