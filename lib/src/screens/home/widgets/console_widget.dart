import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/screens/home/widgets/panel_widget.dart';

class ConsoleWidget extends StatelessWidget {
  const ConsoleWidget({
    super.key,
    required this.isFullScreen,
    required this.onFullScreen,
  });

  final bool isFullScreen;
  final VoidCallback onFullScreen;

  String _extractTableName(SqlCommandsNotifier notifier) {
    if (notifier.result is List && (notifier.result as List).isEmpty) {
      final sql = notifier.lastQuery;
      if (sql == null) return '';

      final match = RegExp(
        r'\bfrom\s+([a-zA-Z_][\w]*)\b',
        caseSensitive: false,
      ).firstMatch(sql);

      return match?.group(1) ?? '';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SqlCommandsNotifier>(
      builder: (context, notifier, child) {
        Widget content;

        if (notifier.isLoading) {
          content = const Padding(
            padding: EdgeInsets.all(16.0),
            child: LinearProgressIndicator(),
          );
        } else if (notifier.error != null) {
          content = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              notifier.error!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (notifier.result == null) {
          content = const SizedBox.shrink();
        } else if (notifier.result is List) {
          final rows = notifier.result as List<Map<String, dynamic>>;

          if (rows.isEmpty) {
            content = FutureBuilder<List<String>>(
              future: notifier.getTableColumns(_extractTableName(notifier)),
              builder: (context, snapshot) {
                final columns = snapshot.data ?? <String>[];
                if (columns.isEmpty) return const SizedBox.shrink();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StyledDataTable(
                        columns: columns,
                        rows: const <Map<String, dynamic>>[],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            final columns = rows.first.keys.toList();

            content = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StyledDataTable(columns: columns, rows: rows),
                ),
              ),
            );
          }
        } else {
          content = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Command executed (${notifier.result}) rows affected.',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          );
        }

        return PanelWidget(
          title: 'Console',
          isFullScreen: isFullScreen,
          onFullScreen: onFullScreen,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.clear_rounded),
              tooltip: 'Clear Console',
              onPressed: () => notifier.clearResult(),
            ),
          ],
          child: content,
        );
      },
    );
  }
}

class StyledDataTable extends StatelessWidget {
  const StyledDataTable({super.key, required this.columns, required this.rows});

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
