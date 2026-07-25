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
  /// other cards appearing at the same time. [isSelected] highlights the
  /// card as the focus of a relation trace, while [isDimmed] fades it out
  /// when another table's relations are being traced.
  const DatabaseVisualizerTableWidget({
    required this.table,
    this.entryIndex = 0,
    this.isSelected = false,
    this.isDimmed = false,
    this.onTap,
    super.key,
  });

  /// The table whose structure is displayed.
  final TableInfoModel table;

  /// The position of this card among the tables appearing together, used to
  /// stagger its entrance animation.
  final int entryIndex;

  /// Whether this card is the currently selected relation-trace focus.
  final bool isSelected;

  /// Whether this card should fade out because another table is selected.
  final bool isDimmed;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

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
      opacity: _visible ? (widget.isDimmed ? 0.35 : 1) : 0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: AnimatedScale(
        scale: _visible ? 1 : 0.92,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: GestureDetector(onTap: widget.onTap, child: _buildCard()),
      ),
    );
  }

  static const double _borderWidth = 2;

  Widget _buildCard() {
    final table = widget.table;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 260,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(
          color: widget.isSelected ? AppColors.black : AppColors.transparent,
          width: _borderWidth,
        ),
        boxShadow: AppShadows.card,
      ),
      // The single source of truth for corner rounding: children below are
      // plain rectangles, and are inset by the border width so their clip
      // radius nests exactly under the outer border's curve instead of
      // fighting it for the same pixels (which produced a visible seam).
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.md - _borderWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              color: AppColors.black,
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.table_chart_rounded,
                    color: AppColors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      table.name.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.white,
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
                          color: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      column.type.toLowerCase(),
                      style: TextStyle(
                        color: AppColors.black.withAlpha(100),
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
      ),
    );
  }
}
