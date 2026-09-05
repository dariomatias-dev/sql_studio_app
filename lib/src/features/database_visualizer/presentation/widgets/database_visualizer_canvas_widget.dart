import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/painters/grid_background_painter.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/painters/table_relation_painter.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/utils/table_layout_calculator.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/widgets/database_visualizer_table_widget.dart';

/// Pannable, zoomable canvas that renders a database's tables and their
/// foreign-key relations, laid out in a grid.
class DatabaseVisualizerCanvasWidget extends StatefulWidget {
  /// Creates the visualizer canvas for [tables].
  const DatabaseVisualizerCanvasWidget({
    required this.tables,
    required this.transformationController,
    required this.selectedTable,
    required this.onSelectTable,
    required this.onOpenTable,
    super.key,
  });

  /// The tables to render.
  final List<TableInfoEntity> tables;

  /// Controller shared with the zoom controls, driving pan/zoom.
  final TransformationController transformationController;

  /// The name of the table currently focused for relation tracing, if any.
  final String? selectedTable;

  /// Called with a table's name when it's tapped, or `null` when the
  /// background is tapped to clear the selection.
  final ValueChanged<String?> onSelectTable;

  /// Called with a table's name when its "open table" action is tapped.
  final ValueChanged<String> onOpenTable;

  @override
  State<DatabaseVisualizerCanvasWidget> createState() =>
      _DatabaseVisualizerCanvasWidgetState();
}

class _DatabaseVisualizerCanvasWidgetState
    extends State<DatabaseVisualizerCanvasWidget> {
  static const double _minFitScale = 0.2;
  static const double _maxFitScale = 1;

  bool _linesVisible = false;
  bool _didFitToView = false;

  @override
  void initState() {
    super.initState();
    _scheduleLines();
  }

  @override
  void didUpdateWidget(covariant DatabaseVisualizerCanvasWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(oldWidget.tables, widget.tables)) {
      _linesVisible = false;
      _didFitToView = false;
      _scheduleLines();
    }
  }

  /// Centers and scales the diagram so every table fits within [viewport]
  /// the first time it's laid out, instead of opening at the top-left
  /// corner of the grid.
  void _fitToView(Size content, Size viewport) {
    if (content.width == 0 || content.height == 0) return;

    final scale = math
        .min(viewport.width / content.width, viewport.height / content.height)
        .clamp(_minFitScale, _maxFitScale);
    final dx = (viewport.width - content.width * scale) / 2;
    final dy = (viewport.height - content.height * scale) / 2;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.transformationController.value = Matrix4.identity()
        ..translateByDouble(dx, dy, 0, 1)
        ..scaleByDouble(scale, scale, scale, 1);
    });
  }

  void _scheduleLines() {
    // Relations only make sense once their tables are visible, so lines
    // fade in after the last staggered table card has settled instead of
    // popping in fully drawn before the diagram exists.
    final lastCardDelay = 40 * (widget.tables.length - 1).clamp(0, 1 << 30);
    final delay = Duration(milliseconds: lastCardDelay + 200);

    Future.delayed(delay, () {
      if (mounted) setState(() => _linesVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tables = widget.tables;
    final transformationController = widget.transformationController;
    final selectedTable = widget.selectedTable;
    final onSelectTable = widget.onSelectTable;
    final onOpenTable = widget.onOpenTable;

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = TableLayoutCalculator.layout(
          tables,
          Size(constraints.maxWidth, constraints.maxHeight),
        );
        final tableRects = layout.tableRects;
        final canvasSize = layout.canvasSize;

        if (!_didFitToView) {
          _didFitToView = true;
          _fitToView(
            layout.contentSize,
            Size(constraints.maxWidth, constraints.maxHeight),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: GridBackgroundPainter(colors: context.colors),
              ),
            ),
            InteractiveViewer(
              transformationController: transformationController,
              constrained: false,
              scaleFactor: 1000,
              minScale: 0.2,
              maxScale: 2,
              boundaryMargin: const EdgeInsets.all(5000),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onSelectTable(null),
                child: SizedBox(
                  width: canvasSize.width,
                  height: canvasSize.height,
                  child: Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: _linesVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: CustomPaint(
                          size: canvasSize,
                          painter: TableRelationPainter(
                            tables: tables,
                            tableRects: tableRects,
                            tableHeaderHeight:
                                TableLayoutCalculator.headerHeight,
                            tableColumnRowHeight:
                                TableLayoutCalculator.columnRowHeight,
                            selectedTable: selectedTable,
                            colors: context.colors,
                          ),
                        ),
                      ),
                      ...tables.indexed.map((entry) {
                        final (index, table) = entry;
                        final rect = tableRects[table.name];
                        if (rect == null) return const SizedBox();

                        final hasSelection = selectedTable != null;
                        final isSelected = table.name == selectedTable;
                        final isRelated =
                            hasSelection &&
                            !isSelected &&
                            _isRelated(table, selectedTable);

                        return Positioned(
                          left: rect.left,
                          top: rect.top,
                          width: rect.width,
                          height: rect.height,
                          child: DatabaseVisualizerTableWidget(
                            table: table,
                            entryIndex: index,
                            isSelected: isSelected,
                            isDimmed: hasSelection && !isSelected && !isRelated,
                            onTap: () =>
                                onSelectTable(isSelected ? null : table.name),
                            onOpen: () => onOpenTable(table.name),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isRelated(TableInfoEntity table, String selectedTable) {
    if (table.name == selectedTable) return true;

    for (final column in table.columns) {
      if (column.foreignTable == selectedTable) return true;
    }

    final selected = widget.tables
        .where((t) => t.name == selectedTable)
        .firstOrNull;
    if (selected == null) return false;

    return selected.columns.any((column) => column.foreignTable == table.name);
  }
}
