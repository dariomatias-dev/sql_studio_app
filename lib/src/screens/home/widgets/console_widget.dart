import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<SqlCommandsNotifier>(
      builder: (context, notifier, child) {
        Widget content;

        if (notifier.isLoading) {
          content = const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: LinearProgressIndicator(),
          );
        } else if (notifier.error != null) {
          content = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              notifier.error!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (notifier.result == null) {
          content = const SizedBox.shrink();
        } else if (notifier.result is List) {
          final rows = notifier.result as List<Map<String, dynamic>>;

          if (rows.isEmpty) {
            content = const SizedBox.shrink();
          } else {
            final columns = rows.first.keys.toList();

            content = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DataTable(
                  columns: columns
                      .map((col) => DataColumn(label: Text(col)))
                      .toList(),
                  rows: rows
                      .map(
                        (r) => DataRow(
                          cells: columns
                              .map((c) => DataCell(Text('${r[c]}')))
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          }
        } else {
          content = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Command executed (${notifier.result}) rows affected.'),
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