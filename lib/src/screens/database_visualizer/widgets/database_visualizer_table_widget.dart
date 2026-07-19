import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/models/table_info_model.dart';

/// Card that renders a single table's name and columns in the database
/// visualizer diagram.
class DatabaseVisualizerTableWidget extends StatelessWidget {
  /// Creates a card representing [table].
  const DatabaseVisualizerTableWidget({required this.table, super.key});

  /// The table whose structure is displayed.
  final TableInfoModel table;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.table_chart_rounded,
                  color: Colors.white,
                  size: 18,
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
                  bottom: BorderSide(color: Color(0xFFF5F5F5)),
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
                        color: Color(0xFF757575),
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
