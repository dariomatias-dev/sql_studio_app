import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// A non-interactive label grouping related entries within a popup menu.
class PopupMenuSectionHeaderWidget extends PopupMenuItem<void> {
  /// Creates a section header showing [label].
  PopupMenuSectionHeaderWidget({required String label, super.key})
    : super(
        enabled: false,
        height: 28,
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textMuted,
          ),
        ),
      );
}
