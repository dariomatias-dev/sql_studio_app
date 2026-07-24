import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';

/// A draggable horizontal bar used to resize the panels above and below it
/// in a workspace split view.
class DividerBarWidget extends StatelessWidget {
  /// Creates a divider bar that reports drag updates via [onDragUpdate].
  const DividerBarWidget({required this.onDragUpdate, super.key});

  /// Called with the drag delta whenever the bar is dragged vertically.
  final GestureDragUpdateCallback onDragUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: onDragUpdate,
      child: Container(
        height: 12,
        color: AppColors.surface,
        child: Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.controlInactive,
              borderRadius: BorderRadius.circular(AppRadii.full),
            ),
          ),
        ),
      ),
    );
  }
}
