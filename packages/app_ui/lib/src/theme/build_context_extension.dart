import 'package:app_ui/src/tokens/app_colors.dart';
import 'package:flutter/material.dart';

/// Convenience accessors for values derived from [BuildContext].
extension BuildContextExtension on BuildContext {
  /// The [AppColors] palette matching the currently active theme.
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
