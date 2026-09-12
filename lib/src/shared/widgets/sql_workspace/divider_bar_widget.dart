import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border(top: BorderSide(color: context.colors.border)),
        ),
        child: Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.controlInactive,
              borderRadius: BorderRadius.circular(AppRadii.full),
            ),
          ),
        ),
      ),
    );
  }
}
