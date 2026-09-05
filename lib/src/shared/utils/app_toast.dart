import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Shows short, transient feedback messages with the app's single,
/// consistent toast style.
class AppToast {
  /// Creates a toast styled for a dark surface when [isDark] is true.
  const AppToast({required this.isDark});

  /// Creates a toast matching the theme in effect at [context]. Resolve
  /// it before any `await`, the way localizations are resolved.
  factory AppToast.of(BuildContext context) =>
      AppToast(isDark: Theme.of(context).brightness == Brightness.dark);

  /// Whether the toast is drawn for a dark surface, flipping to a white
  /// chip so it stays legible.
  final bool isDark;

  /// Shows [message] in a toast styled consistently across the app.
  Future<void> show(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: isDark ? Colors.white : Colors.black,
      textColor: isDark ? Colors.black : Colors.white,
      fontSize: 14,
    );
  }
}
