import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';

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
          content = Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 4.0,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          );
        } else if (notifier.error != null) {
          content = SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
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
                      child: StyledDataTableWidget(
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

            content = Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      right: 16.0,
                      left: 16.0,
                    ),
                    child: StyledDataTableWidget(columns: columns, rows: rows),
                  ),
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
              onPressed: notifier.clearResult,
              icon: const Icon(Icons.clear_rounded),
              tooltip: 'Clear Console',
            ),
          ],
          child: content,
        );
      },
    );
  }
}
