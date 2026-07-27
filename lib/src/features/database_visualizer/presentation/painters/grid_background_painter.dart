import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// Paints the faint dot/line grid behind the database visualizer canvas.
class GridBackgroundPainter extends CustomPainter {
  /// Creates a grid background painter using [colors].
  const GridBackgroundPainter({required this.colors});

  /// The theme's color palette, used to tint the grid lines.
  final AppColors colors;

  static const double _step = 28;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colors.black.withAlpha(12)
      ..strokeWidth = 1;

    for (double i = 0; i <= size.width; i += _step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i <= size.height; i += _step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridBackgroundPainter oldDelegate) =>
      oldDelegate.colors != colors;
}
