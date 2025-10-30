import 'package:flutter/material.dart';

class SnackBarUtils {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Ok', onPressed: () {}),
      ),
    );
  }
}
