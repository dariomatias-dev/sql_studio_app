import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';

/// A [DataTable] with a consistent black-and-white style used to render
/// SQL query results.
class StyledDataTableWidget extends StatelessWidget {
  /// Creates a styled data table for the given [columns] and [rows].
  const StyledDataTableWidget({
    required this.columns,
    required this.rows,
    super.key,
  });

  /// Names of the columns to display, in order.
  final List<String> columns;

  /// Row data, each entry mapping a column name to its value.
  final List<Map<String, dynamic>> rows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.all(context.colors.background),
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: context.colors.black87,
      ),
      dataRowColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? context.colors.black.withAlpha(15)
            : context.colors.white;
      }),
      columns: columns.builder((col, index) => DataColumn(label: Text(col))),
      rows: rows.builder(
        (row, rowIndex) => DataRow(
          cells: columns.builder(
            (col, colIndex) => DataCell(
              Text('${row[col]}', style: const TextStyle(fontSize: 14)),
            ),
          ),
        ),
      ),
      dividerThickness: 1,
      horizontalMargin: 12,
      columnSpacing: 24,
    );
  }
}
