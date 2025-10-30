import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';

class StyledDataTableWidget extends StatelessWidget {
  const StyledDataTableWidget({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<String> columns;
  final List<Map<String, dynamic>> rows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.all(Colors.blueGrey.shade50),
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      dataRowColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? Colors.blue.withAlpha(25)
            : Colors.white;
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
