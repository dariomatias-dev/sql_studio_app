import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// Convenience accessors for values derived from [BuildContext].
extension BuildContextExtension on BuildContext {
  /// The [AppColors] palette matching the currently active theme.
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
