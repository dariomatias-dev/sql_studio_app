import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_controller.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';

/// Displays the result of the last executed SQL command, showing a loading
/// indicator, an error message, or the resulting data table as appropriate.
class ConsoleWidget extends StatefulWidget {
  /// Creates a console panel bound to the current [SqlCommandsNotifier].
  const ConsoleWidget({
    super.key,
    this.showTitle = true,
    this.isFullScreen,
    this.onFullScreen,
  });

  /// Whether the panel title should be displayed.
  final bool showTitle;

  /// Whether the panel is currently expanded to full screen.
  final bool? isFullScreen;

  /// Called when the full screen toggle button is pressed.
  final VoidCallback? onFullScreen;

  @override
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  final _controller = ConsoleController();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Consumer<SqlCommandsNotifier>(
      builder: (context, notifier, child) {
        Widget content;

        if (notifier.isLoading) {
          content = Align(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 4,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          );
        } else if (notifier.error != null) {
          content = SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(
              appLocalizations.key(notifier.error!, notifier.errorArgs ?? {}),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (notifier.result == null) {
          content = const SizedBox.shrink();
        } else {
          final result = (notifier.result! as SuccessResult).value;

          if (result is DatabaseSuccess) {
            if (result.result is List) {
              final rows = result.result! as List<Map<String, dynamic>>;

              if (rows.isEmpty) {
                content = FutureBuilder<List<String>>(
                  future: notifier.getTableColumns(
                    _controller.extractTableName(notifier),
                  ),
                  builder: (context, snapshot) {
                    final columns = snapshot.data ?? <String>[];
                    if (columns.isEmpty) return const SizedBox.shrink();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
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
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          right: 16,
                          left: 16,
                        ),
                        child: StyledDataTableWidget(
                          columns: columns,
                          rows: rows,
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else {
              final text = result.type != null
                  ? appLocalizations.key(result.type!, result.args)
                  : '';

              content = Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              );
            }
          } else {
            content = const SizedBox.shrink();
          }
        }

        return PanelWidget(
          title: widget.showTitle ? appLocalizations.console : null,
          isFullScreen: widget.isFullScreen,
          onFullScreen: widget.onFullScreen,
          actions: <Widget>[
            IconButton(
              onPressed: notifier.clearResult,
              tooltip: appLocalizations.clearConsole,
              icon: const Icon(Icons.clear_rounded),
            ),
          ],
          child: content,
        );
      },
    );
  }
}
