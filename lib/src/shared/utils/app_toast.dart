import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Shows short, transient feedback messages with the app's single,
/// consistent toast style.
class AppToast {
  const AppToast._();

  /// Shows [message] in a toast styled consistently across the app.
  ///
  /// Intentionally theme-independent: the toast stays a fixed dark chip
  /// regardless of the app's light/dark theme.
  static Future<void> show(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}
