import 'package:flutter/material.dart';

class DividerBar extends StatelessWidget {
  const DividerBar({super.key, required this.onDragUpdate});

  final GestureDragUpdateCallback onDragUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: onDragUpdate,
      child: Container(
        height: 12.0,
        color: Colors.grey.shade300,
        child: Center(
          child: Container(
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
      ),
    );
  }
}
