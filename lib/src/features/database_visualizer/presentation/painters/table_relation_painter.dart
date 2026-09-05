import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';

/// Paints the foreign-key relation arrows between visualized tables.
///
/// When [selectedTable] is set, relations touching it are drawn emphasized
/// while every other relation is faded out, helping trace a table's
/// connections in dense diagrams.
class TableRelationPainter extends CustomPainter {
  /// Creates a painter for the relations between [tables], positioned
  /// according to [tableRects].
  TableRelationPainter({
    required this.tables,
    required this.tableRects,
    required this.tableHeaderHeight,
    required this.tableColumnRowHeight,
    required this.colors,
    this.selectedTable,
  });

  /// The tables whose relations are drawn.
  final List<TableInfoEntity> tables;

  /// The on-screen bounds of each table, keyed by table name.
  final Map<String, Rect> tableRects;

  /// The height of a table's header, used to position relation lines.
  final double tableHeaderHeight;

  /// The height of a single column row, used to position relation lines.
  final double tableColumnRowHeight;

  /// The name of the currently selected table, if any.
  final String? selectedTable;

  /// The theme's color palette, used to tint relation lines and markers.
  final AppColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final hasSelection = selectedTable != null;

    // Opaque (non-alpha) colors: overlapping relation curves are common in
    // dense diagrams, and translucent strokes darken cumulatively wherever
    // they cross, making some segments read as heavier than others.
    final dimmedColor = colors.disabled;
    final normalColor = colors.textMuted;

    final dimmedPaint = Paint()
      ..color = dimmedColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final dimmedMarkPaint = Paint()
      ..color = dimmedColor
      ..style = PaintingStyle.fill;

    final normalPaint = Paint()
      ..color = normalColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final normalMarkPaint = Paint()
      ..color = normalColor
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = colors.black
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final highlightMarkPaint = Paint()
      ..color = colors.black
      ..style = PaintingStyle.fill;

    for (final source in tables) {
      final sourceRect = tableRects[source.name];
      if (sourceRect == null) continue;

      for (var i = 0; i < source.columns.length; i++) {
        final column = source.columns[i];

        if (column.foreignTable == null) continue;

        final targetRect = tableRects[column.foreignTable];
        if (targetRect == null) continue;

        final touchesSelection =
            source.name == selectedTable ||
            column.foreignTable == selectedTable;

        final Paint linePaint;
        final Paint markPaint;

        if (!hasSelection) {
          linePaint = normalPaint;
          markPaint = normalMarkPaint;
        } else if (touchesSelection) {
          linePaint = highlightPaint;
          markPaint = highlightMarkPaint;
        } else {
          linePaint = dimmedPaint;
          markPaint = dimmedMarkPaint;
        }

        final y =
            sourceRect.top +
            tableHeaderHeight +
            i * tableColumnRowHeight +
            tableColumnRowHeight / 2;

        final start = targetRect.center.dx > sourceRect.center.dx
            ? Offset(sourceRect.right, y)
            : Offset(sourceRect.left, y);

        final end = _intersection(start, targetRect);

        final controlX = start.dx + (end.dx - start.dx) / 2;

        final path = Path()
          ..moveTo(start.dx, start.dy)
          ..cubicTo(controlX, start.dy, controlX, end.dy, end.dx, end.dy);

        canvas.drawPath(path, linePaint);

        final direction = end.dx >= start.dx ? 1.0 : -1.0;
        _manyMark(canvas, start, direction, markPaint);
        _oneMark(canvas, end, markPaint);
      }
    }
  }

  Offset _intersection(Offset p1, Rect rect) {
    final p2 = rect.center;
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;

    if (dx.abs() > dy.abs()) {
      return dx > 0 ? Offset(rect.left, p2.dy) : Offset(rect.right, p2.dy);
    }

    return dy > 0 ? Offset(p2.dx, rect.top) : Offset(p2.dx, rect.bottom);
  }

  /// Draws a crow's-foot fork at the "many" end of a relation (the table
  /// holding the foreign key column), fanning outward from [at] along
  /// [direction] (1 for rightward, -1 for leftward).
  void _manyMark(Canvas canvas, Offset at, double direction, Paint paint) {
    const spread = 8.0;
    const length = 12.0;

    final linePaint = Paint()
      ..color = paint.color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final dy in [-spread, 0.0, spread]) {
      canvas.drawLine(
        at,
        Offset(at.dx + direction * length, at.dy + dy),
        linePaint,
      );
    }
  }

  /// Draws a filled circle marking the "one" end of a relation (the
  /// referenced table).
  void _oneMark(Canvas canvas, Offset at, Paint paint) {
    const radius = 4.0;

    canvas.drawCircle(at, radius, paint);
  }

  @override
  bool shouldRepaint(covariant TableRelationPainter oldDelegate) =>
      oldDelegate.tables != tables ||
      oldDelegate.tableRects != tableRects ||
      oldDelegate.tableHeaderHeight != tableHeaderHeight ||
      oldDelegate.tableColumnRowHeight != tableColumnRowHeight ||
      oldDelegate.selectedTable != selectedTable ||
      oldDelegate.colors != colors;
}
