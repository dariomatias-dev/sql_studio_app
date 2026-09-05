import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';

/// A [DataTable] with a consistent black-and-white style used to render
/// SQL query results, one page at a time so a large result set does not
/// build every row at once.
class StyledDataTableWidget extends StatefulWidget {
  /// Creates a styled data table for the given [columns] and [rows].
  const StyledDataTableWidget({
    required this.columns,
    required this.rows,
    super.key,
  });

  /// Rows built per page. A `SELECT` over a large table would otherwise
  /// materialize one `DataRow` per returned row.
  static const rowsPerPage = 50;

  /// Names of the columns to display, in order.
  final List<String> columns;

  /// Row data, each entry mapping a column name to its value.
  final List<Map<String, dynamic>> rows;

  @override
  State<StyledDataTableWidget> createState() => _StyledDataTableWidgetState();
}

class _StyledDataTableWidgetState extends State<StyledDataTableWidget> {
  var _page = 0;

  int get _pageCount =>
      (widget.rows.length / StyledDataTableWidget.rowsPerPage).ceil();

  int get _start => _page * StyledDataTableWidget.rowsPerPage;

  int get _end =>
      (_start + StyledDataTableWidget.rowsPerPage) > widget.rows.length
      ? widget.rows.length
      : _start + StyledDataTableWidget.rowsPerPage;

  @override
  void didUpdateWidget(StyledDataTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.rows != widget.rows && _page != 0) {
      setState(() => _page = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageRows = widget.rows.sublist(_start, _end);

    final table = DataTable(
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
      columns: widget.columns.builder(
        (col, index) => DataColumn(label: Text(col)),
      ),
      rows: pageRows.builder(
        (row, rowIndex) => DataRow(
          cells: widget.columns.builder(
            (col, colIndex) => DataCell(
              Text('${row[col]}', style: const TextStyle(fontSize: 14)),
            ),
          ),
        ),
      ),
      dividerThickness: 1,
      horizontalMargin: AppSpacing.sm,
      columnSpacing: AppSpacing.lg,
    );

    if (_pageCount <= 1) return table;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[table, _buildPager(context)],
    );
  }

  Widget _buildPager(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: _page == 0 ? null : () => setState(() => _page--),
            tooltip: appLocalizations.previousPage,
            icon: const Icon(Icons.chevron_left),
            visualDensity: VisualDensity.compact,
          ),
          Text(
            appLocalizations.tableRowsRange(
              _start + 1,
              _end,
              widget.rows.length,
            ),
            style: TextStyle(fontSize: 13, color: context.colors.textMuted),
          ),
          IconButton(
            onPressed: _page >= _pageCount - 1
                ? null
                : () => setState(() => _page++),
            tooltip: appLocalizations.nextPage,
            icon: const Icon(Icons.chevron_right),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
