import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_shadows.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Card that renders a single table's name and columns in the database
/// visualizer diagram.
class DatabaseVisualizerTableWidget extends StatefulWidget {
  /// Creates a card representing [table].
  ///
  /// [entryIndex] staggers this card's entrance animation relative to
  /// other cards appearing at the same time.
  const DatabaseVisualizerTableWidget({
    required this.table,
    this.entryIndex = 0,
    super.key,
  });

  /// The table whose structure is displayed.
  final TableInfoModel table;

  /// The position of this card among the tables appearing together, used to
  /// stagger its entrance animation.
  final int entryIndex;

  @override
  State<DatabaseVisualizerTableWidget> createState() =>
      _DatabaseVisualizerTableWidgetState();
}

class _DatabaseVisualizerTableWidgetState
    extends State<DatabaseVisualizerTableWidget> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 40 * widget.entryIndex), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: AnimatedScale(
        scale: _visible ? 1 : 0.92,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    final table = widget.table;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadii.md),
              ),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.table_chart_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    table.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...table.columns.map((column) {
            final isFk = column.foreignTable != null;

            return Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.border),
                ),
              ),
              child: Row(
                children: <Widget>[
                  if (isFk)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.link_rounded,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      column.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    column.type.toLowerCase(),
                    style: TextStyle(
                      color: Colors.black.withAlpha(100),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
