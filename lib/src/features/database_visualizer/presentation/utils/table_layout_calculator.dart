import 'dart:math' as math;
import 'dart:ui';

import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Result of laying out a set of tables on the visualizer canvas.
class TableLayoutResult {
  /// Creates a layout result.
  const TableLayoutResult({
    required this.tableRects,
    required this.canvasSize,
    required this.contentSize,
  });

  /// The on-screen bounds of each table, keyed by table name.
  final Map<String, Rect> tableRects;

  /// The total size the canvas must have to fit every table plus padding.
  final Size canvasSize;

  /// The actual bounding size of the laid-out tables, ignoring any padding
  /// added to make [canvasSize] at least as large as the viewport. Used to
  /// fit the diagram to the viewport when the visualizer first opens.
  final Size contentSize;
}

/// Arranges [TableInfoModel]s into a grid for the database visualizer
/// diagram, computing each table's on-screen bounds.
class TableLayoutCalculator {
  const TableLayoutCalculator._();

  static const double _tableWidth = 260;
  static const double _headerHeight = 54;
  static const double _columnRowHeight = 44;
  static const double _footerHeight = 12;
  static const double _padding = 100;
  static const int _columnsInGrid = 3;

  /// Computes a grid layout for [tables], guaranteeing the resulting
  /// canvas is at least as large as [minSize].
  static TableLayoutResult layout(List<TableInfoModel> tables, Size minSize) {
    final tableRects = <String, Rect>{};

    var currentX = _padding;
    var currentY = _padding;
    var currentRowMaxHeight = 0.0;

    for (var i = 0; i < tables.length; i++) {
      final table = tables[i];
      final height =
          _headerHeight +
          _footerHeight +
          table.columns.length * _columnRowHeight;

      if (i > 0 && i % _columnsInGrid == 0) {
        currentX = _padding;
        currentY += currentRowMaxHeight + _padding;
        currentRowMaxHeight = 0;
      }

      tableRects[table.name] = Rect.fromLTWH(
        currentX,
        currentY,
        _tableWidth,
        height,
      );

      currentX += _tableWidth + _padding;
      currentRowMaxHeight = math.max(currentRowMaxHeight, height);
    }

    final contentWidth = tableRects.values.isEmpty
        ? 0.0
        : tableRects.values.map((e) => e.right).reduce(math.max) + _padding;
    final contentHeight = tableRects.values.isEmpty
        ? 0.0
        : tableRects.values.map((e) => e.bottom).reduce(math.max) + _padding;

    return TableLayoutResult(
      tableRects: tableRects,
      canvasSize: Size(
        math.max(contentWidth, minSize.width),
        math.max(contentHeight, minSize.height),
      ),
      contentSize: Size(contentWidth, contentHeight),
    );
  }

  /// Header height used when positioning relation lines against a table.
  static double get headerHeight => _headerHeight;

  /// Column row height used when positioning relation lines against a
  /// table.
  static double get columnRowHeight => _columnRowHeight;
}
