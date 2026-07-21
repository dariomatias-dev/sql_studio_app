import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';

import 'package:sql_studio/src/features/database_visualizer/presentation/widgets/database_visualizer_table_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

/// Screen that renders an interactive diagram of a database's tables and
/// their relations.
class DatabaseVisualizerScreen extends ConsumerStatefulWidget {
  /// Creates the visualizer screen for the database named [databaseName].
  const DatabaseVisualizerScreen({required this.databaseName, super.key});

  /// The name of the database whose structure is being visualized.
  final String databaseName;

  @override
  ConsumerState<DatabaseVisualizerScreen> createState() =>
      _DatabaseVisualizerScreenState();
}

class _DatabaseVisualizerScreenState
    extends ConsumerState<DatabaseVisualizerScreen> {
  final _tableRects = <String, Rect>{};

  static const _tableWidgetWidth = 260.0;
  static const _tableHeaderHeight = 54.0;
  static const _tableColumnRowHeight = 44.0;
  static const _tableFooterHeight = 12.0;
  static const _tablePadding = 100.0;

  Future<void> _loadDatabaseStructure() async {
    // Discards any structure left over from a previously visualized
    // database, since this view model is a long-lived singleton.
    ref.invalidate(databaseVisualizerViewModelProvider);

    await ref
        .read(databaseVisualizerViewModelProvider.notifier)
        .load(widget.databaseName);

    if (!mounted) return;

    setState(_calculateTableRects);
  }

  void _calculateTableRects() {
    final tables = ref.read(databaseVisualizerViewModelProvider).tables;

    _tableRects.clear();
    if (tables == null || tables.isEmpty) return;

    var currentX = _tablePadding;
    var currentY = _tablePadding;
    double currentRowMaxHeight = 0;

    const columnsInGrid = 3;

    for (var i = 0; i < tables.length; i++) {
      final table = tables[i];

      final height =
          _tableHeaderHeight +
          _tableFooterHeight +
          table.columns.length * _tableColumnRowHeight;

      if (i > 0 && i % columnsInGrid == 0) {
        currentX = _tablePadding;
        currentY += currentRowMaxHeight + _tablePadding;
        currentRowMaxHeight = 0.0;
      }

      _tableRects[table.name] = Rect.fromLTWH(
        currentX,
        currentY,
        _tableWidgetWidth,
        height,
      );

      currentX += _tableWidgetWidth + _tablePadding;
      currentRowMaxHeight = math.max(currentRowMaxHeight, height);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadDatabaseStructure());
    });
  }

  @override
  Widget build(BuildContext context) {
    final tables = ref.watch(
      databaseVisualizerViewModelProvider.select((s) => s.tables),
    );

    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(
          widget.databaseName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Color(0xFFF2F2F2))),
      ),
      body: SafeArea(
        child: tables == null
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : tables.isEmpty
            ? Center(
                child: Text(AppLocalizations.of(context)!.theDatabaseIsEmpty),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  var contentWidth =
                      _tableRects.values
                          .map((e) => e.right)
                          .fold<double>(0, math.max) +
                      _tablePadding;

                  var contentHeight =
                      _tableRects.values
                          .map((e) => e.bottom)
                          .fold<double>(0, math.max) +
                      _tablePadding;

                  contentWidth = math.max(contentWidth, constraints.maxWidth);
                  contentHeight = math.max(
                    contentHeight,
                    constraints.maxHeight,
                  );

                  return Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(painter: _GridBackgroundPainter()),
                      ),
                      InteractiveViewer(
                        constrained: false,
                        scaleFactor: 1000,
                        minScale: 0.2,
                        maxScale: 2,
                        boundaryMargin: const EdgeInsets.all(5000),
                        child: SizedBox(
                          width: contentWidth,
                          height: contentHeight,
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(contentWidth, contentHeight),
                                painter: TableRelationPainter(
                                  tables: tables,
                                  tableRects: _tableRects,
                                  tableHeaderHeight: _tableHeaderHeight,
                                  tableColumnRowHeight: _tableColumnRowHeight,
                                ),
                              ),
                              ...tables.map((table) {
                                final rect = _tableRects[table.name];
                                if (rect == null) return const SizedBox();

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
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}

class _GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withAlpha(12)
      ..strokeWidth = 1;

    const step = 28.0;

    for (double i = 0; i <= size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i <= size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Paints the foreign-key relation arrows between visualized tables.
class TableRelationPainter extends CustomPainter {
  /// Creates a painter for the relations between [tables], positioned
  /// according to [tableRects].
  TableRelationPainter({
    required this.tables,
    required this.tableRects,
    required this.tableHeaderHeight,
    required this.tableColumnRowHeight,
  });

  /// The tables whose relations are drawn.
  final List<TableInfoModel> tables;

  /// The on-screen bounds of each table, keyed by table name.
  final Map<String, Rect> tableRects;

  /// The height of a table's header, used to position relation lines.
  final double tableHeaderHeight;

  /// The height of a single column row, used to position relation lines.
  final double tableColumnRowHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withAlpha(100)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final arrowPaint = Paint()
      ..color = Colors.black.withAlpha(100)
      ..style = PaintingStyle.fill;

    for (final source in tables) {
      final sourceRect = tableRects[source.name];
      if (sourceRect == null) continue;

      for (var i = 0; i < source.columns.length; i++) {
        final column = source.columns[i];

        if (column.foreignTable == null) continue;

        final targetRect = tableRects[column.foreignTable];
        if (targetRect == null) continue;

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

        canvas.drawPath(path, paint);
        _arrow(canvas, end, Offset(controlX, end.dy), arrowPaint);
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

  void _arrow(Canvas canvas, Offset tip, Offset tail, Paint paint) {
    const size = 8.0;
    final angle = math.atan2(tip.dy - tail.dy, tip.dx - tail.dx);

    final path = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(
        tip.dx - size * math.cos(angle - math.pi / 6),
        tip.dy - size * math.sin(angle - math.pi / 6),
      )
      ..lineTo(
        tip.dx - size * math.cos(angle + math.pi / 6),
        tip.dy - size * math.sin(angle + math.pi / 6),
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
