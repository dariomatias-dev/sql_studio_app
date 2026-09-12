import 'package:flutter/material.dart';

/// Upper bound applied to the platform text scale. Beyond this, the
/// editor toolbar, the nav bar labels and the console table overflow.
const maxTextScaleFactor = 1.4;

/// Wraps [child] so text never scales past [maxTextScaleFactor], keeping
/// the user's smaller scales untouched. Use as a [MaterialApp] builder.
Widget clampTextScaling(BuildContext context, Widget? child) {
  final mediaQuery = MediaQuery.of(context);

  return MediaQuery(
    data: mediaQuery.copyWith(
      textScaler: mediaQuery.textScaler.clamp(
        maxScaleFactor: maxTextScaleFactor,
      ),
    ),
    child: child ?? const SizedBox.shrink(),
  );
}
