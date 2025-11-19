import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/types/table_info.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/screens/database_visualizer/widgets/database_visualizer_table_widget.dart';

import 'package:sql_studio/src/services/sql_execution_service.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class DatabaseVisualizerScreen extends StatefulWidget {
  const DatabaseVisualizerScreen({super.key});

  @override
  State<DatabaseVisualizerScreen> createState() =>
      _DatabaseVisualizerScreenState();
}

class _DatabaseVisualizerScreenState extends State<DatabaseVisualizerScreen> {
  final _sqlExecutionService = SqlExecutionService();
  List<TableInfo>? tables;
  final _tableRects = <String, Rect>{};

  static const _tableWidgetWidth = 240.0;
  static const _tableHeaderHeight = 60.0;
  static const _tableColumnRowHeight = 40.0;
  static const _tableFooterHeight = 10.0;
  static const _tablePadding = 40.0;

  Future<void> _loadDatabaseStructure() async {
    final result = await _sqlExecutionService.getDatabaseStructure(
      databaseName: context.read<SqlCommandsNotifier>().activeDatabase!,
    );

    setState(() {
      if (result.isNotEmpty) {
        tables = result;
      }

      _calculateTableRects();
    });
  }

  void _calculateTableRects() {
    _tableRects.clear();

    if (tables?.isEmpty ?? true) return;

    final tableWidth = _tableWidgetWidth;
    double currentX = _tablePadding;
    double currentY = _tablePadding;
    int tableCount = 0;

    double currentRowMaxHeight = 0;

    const columnsInGrid = 3;

    for (var table in tables!) {
      final double estimatedTableHeight =
          _tableHeaderHeight +
          _tableFooterHeight +
          (table.columns.length * _tableColumnRowHeight);

      if (tableCount > 0 && tableCount % columnsInGrid == 0) {
        currentX = _tablePadding;
        currentY += currentRowMaxHeight + _tablePadding;
        currentRowMaxHeight = 0;
      }

      _tableRects[table.name] = Rect.fromLTWH(
        currentX,
        currentY,
        tableWidth,
        estimatedTableHeight,
      );

      currentX += tableWidth + _tablePadding;
      currentRowMaxHeight = math.max(currentRowMaxHeight, estimatedTableHeight);
      tableCount++;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDatabaseStructure();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(context.read<SqlCommandsNotifier>().activeDatabase ?? ''),
      ),
      body: SafeArea(
        child: tables == null
            ? const SizedBox.shrink()
            : tables?.isEmpty ?? false
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraints) {
                  double contentWidth =
                      _tableRects.values
                          .map((rect) => rect.right)
                          .fold(0.0, math.max) +
                      _tablePadding;
                  double contentHeight =
                      _tableRects.values
                          .map((rect) => rect.bottom)
                          .fold(0.0, math.max) +
                      _tablePadding;

                  contentWidth = math.max(contentWidth, constraints.maxWidth);
                  contentHeight = math.max(
                    contentHeight,
                    constraints.maxHeight,
                  );

                  return InteractiveViewer(
                    constrained: false,
                    scaleFactor: 0.1,
                    minScale: 0.5,
                    maxScale: 50.0,
                    boundaryMargin: const EdgeInsets.all(1000.0),
                    child: SizedBox(
                      width: contentWidth,
                      child: Stack(
                        children: <Widget>[
                          CustomPaint(
                            painter: TableRelationPainter(
                              tables: tables!,
                              tableRects: _tableRects,
                              tableHeaderHeight: _tableHeaderHeight,
                              tableColumnRowHeight: _tableColumnRowHeight,
                            ),
                            size: Size(contentWidth, contentHeight),
                          ),
                          ...tables!.map((table) {
                            final rect = _tableRects[table.name];

                            if (rect == null) return const SizedBox.shrink();

                            return Positioned(
                              left: rect.left,
                              top: rect.top,
                              width: rect.width,
                              height: rect.height,
                              child: DatabaseVisualizerTableWidget(
                                table: table,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class TableRelationPainter extends CustomPainter {
  final List<TableInfo> tables;
  final Map<String, Rect> tableRects;
  final double tableHeaderHeight;
  final double tableColumnRowHeight;

  TableRelationPainter({
    required this.tables,
    required this.tableRects,
    required this.tableHeaderHeight,
    required this.tableColumnRowHeight,
  });

  Offset _findBoundaryIntersection(Offset p1, Rect rect) {
    final p2 = rect.center;
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;

    double tMin = double.infinity;
    Offset intersection = p2;

    if (dx == 0) {
      if (p1.dy < rect.top && p2.dy > rect.top) return Offset(p2.dx, rect.top);
      if (p1.dy > rect.bottom && p2.dy < rect.bottom) {
        return Offset(p2.dx, rect.bottom);
      }
    }

    if (dy == 0) {
      if (p1.dx < rect.left && p2.dx > rect.left) {
        return Offset(rect.left, p2.dy);
      }
      if (p1.dx > rect.right && p2.dx < rect.right) {
        return Offset(rect.right, p2.dy);
      }
    }

    if (dy != 0) {
      double t = (rect.top - p1.dy) / dy;
      if (t > 0 && t < tMin) {
        double intersectX = p1.dx + t * dx;
        if (intersectX >= rect.left && intersectX <= rect.right) {
          tMin = t;
          intersection = Offset(intersectX, rect.top);
        }
      }
    }

    if (dy != 0) {
      double t = (rect.bottom - p1.dy) / dy;
      if (t > 0 && t < tMin) {
        double intersectX = p1.dx + t * dx;
        if (intersectX >= rect.left && intersectX <= rect.right) {
          tMin = t;
          intersection = Offset(intersectX, rect.bottom);
        }
      }
    }

    if (dx != 0) {
      double t = (rect.left - p1.dx) / dx;
      if (t > 0 && t < tMin) {
        double intersectY = p1.dy + t * dy;
        if (intersectY >= rect.top && intersectY <= rect.bottom) {
          tMin = t;
          intersection = Offset(rect.left, intersectY);
        }
      }
    }

    if (dx != 0) {
      double t = (rect.right - p1.dx) / dx;
      if (t > 0 && t < tMin) {
        double intersectY = p1.dy + t * dy;
        if (intersectY >= rect.top && intersectY <= rect.bottom) {
          tMin = t;
          intersection = Offset(rect.right, intersectY);
        }
      }
    }

    return intersection;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey.shade400
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final arrowPaint = Paint()
      ..color = Colors.blueGrey.shade400
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    for (var sourceTable in tables) {
      final sourceRect = tableRects[sourceTable.name];
      if (sourceRect == null) continue;

      for (int i = 0; i < sourceTable.columns.length; i++) {
        final column = sourceTable.columns[i];

        if (column.foreignTable != null) {
          final targetRect = tableRects[column.foreignTable];
          if (targetRect == null) continue;

          final double columnCenterY =
              sourceRect.top +
              tableHeaderHeight +
              (i * tableColumnRowHeight) +
              (tableColumnRowHeight / 2);

          Offset startPoint;

          if (targetRect.center.dx > sourceRect.center.dx) {
            startPoint = Offset(sourceRect.right, columnCenterY);
          } else {
            startPoint = Offset(sourceRect.left, columnCenterY);
          }

          final Offset endPointForLineAndArrow = _findBoundaryIntersection(
            startPoint,
            targetRect,
          );

          canvas.drawLine(startPoint, endPointForLineAndArrow, paint);
          _drawArrowhead(
            canvas,
            endPointForLineAndArrow,
            startPoint,
            arrowPaint,
          );
        }
      }
    }
  }

  void _drawArrowhead(Canvas canvas, Offset tip, Offset tail, Paint paint) {
    const arrowSize = 10;

    final angle = math.atan2(tip.dy - tail.dy, tip.dx - tail.dx);

    final path = Path();

    path.moveTo(tip.dx, tip.dy);

    path.lineTo(
      tip.dx - arrowSize * math.cos(angle - math.pi / 6),
      tip.dy - arrowSize * math.sin(angle - math.pi / 6),
    );
    path.lineTo(
      tip.dx - arrowSize * math.cos(angle + math.pi / 6),
      tip.dy - arrowSize * math.sin(angle + math.pi / 6),
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is TableRelationPainter) {
      return oldDelegate.tables != tables ||
          oldDelegate.tableRects != tableRects ||
          oldDelegate.tableHeaderHeight != tableHeaderHeight ||
          oldDelegate.tableColumnRowHeight != tableColumnRowHeight;
    }

    return true;
  }
}
