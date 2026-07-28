import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_controller.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/error_state_widget.dart';

/// Displays the result of the last executed SQL command, showing a loading
/// indicator, an error message, or the resulting data table as appropriate.
class ConsoleWidget extends ConsumerStatefulWidget {
  /// Creates a console panel bound to the current SQL command state.
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
  ConsumerState<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends ConsumerState<ConsoleWidget> {
  final _controller = ConsoleController();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final state = ref.watch(sqlCommandsViewModelProvider);
    final commands = ref.read(sqlCommandsViewModelProvider.notifier);

    Widget content;
    var contentKind = 'empty';

    if (state.isLoading) {
      contentKind = 'loading';
      content = Align(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 4,
            child: LinearProgressIndicator(
              backgroundColor: context.colors.border,
              valueColor: AlwaysStoppedAnimation<Color>(context.colors.black),
            ),
          ),
        ),
      );
    } else if (state.error != null) {
      contentKind = 'error';
      content = ErrorStateWidget(
        message: appLocalizations.key(state.error!, state.errorArgs ?? {}),
      );
    } else if (state.result == null) {
      contentKind = 'empty';
      content = EmptyStateWidget(message: appLocalizations.noQueryRunYet);
    } else {
      final result = (state.result! as SuccessResult).value;

      if (result is DatabaseSuccess) {
        if (result.result is List) {
          final rows = result.result! as List<Map<String, dynamic>>;

          if (rows.isEmpty) {
            contentKind = 'columns';
            content = FutureBuilder<List<String>>(
              future: commands.getTableColumns(
                _controller.extractTableName(state),
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

            contentKind = 'rows';
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
                    child: StyledDataTableWidget(columns: columns, rows: rows),
                  ),
                ),
              ),
            );
          }
        } else {
          final text = result.type != null
              ? appLocalizations.key(result.type!, result.args)
              : '';

          contentKind = 'message';
          content = Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          );
        }
      } else {
        contentKind = 'empty';
        content = EmptyStateWidget(
          message: appLocalizations.queryExecutedNoResult,
        );
      }
    }

    return PanelWidget(
      title: widget.showTitle ? appLocalizations.console : null,
      isFullScreen: widget.isFullScreen,
      onFullScreen: widget.onFullScreen,
      actions: <Widget>[
        IconButton(
          onPressed: commands.clearResult,
          tooltip: appLocalizations.clearConsole,
          icon: const Icon(Icons.clear_rounded),
        ),
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(key: ValueKey(contentKind), child: content),
      ),
    );
  }
}
