import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_character_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_basic_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart';

class SqlEditorWidget extends StatelessWidget {
  const SqlEditorWidget({
    super.key,
    this.showTitle = true,
    this.isFullScreen,
    this.onFullScreen,
    this.onQueryRun,
  });

  final bool showTitle;
  final bool? isFullScreen;
  final VoidCallback? onFullScreen;
  final VoidCallback? onQueryRun;

  void _onRunQuery(BuildContext context) {
    final notifier = context.read<SqlCommandsNotifier>();
    final editorNotifier = context.read<SqlEditorNotifier>();
    final sql = editorNotifier.controller.text.trim();

    if (sql.isEmpty) return;

    notifier.runQuery(sql);

    if (onQueryRun != null) onQueryRun!();
  }

  @override
  Widget build(BuildContext context) {
    final sqlCommandsNotifier = context.watch<SqlCommandsNotifier>();
    final suggestionsNotifier = context.watch<SqlSuggestionsNotifier>();
    final editorNotifier = context.watch<SqlEditorNotifier>();
    final databaseName = sqlCommandsNotifier.activeDatabase;

    return PanelWidget(
      title: showTitle ? 'Editor' : null,
      databaseName: databaseName,
      onFullScreen: onFullScreen,
      isFullScreen: isFullScreen,
      actions: <Widget>[
        Consumer<SqlCommandsNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isDefaultDatabase) {
              return IconButton(
                onPressed: sqlCommandsNotifier.resetDatabase,
                tooltip: 'Reset Database',
                icon: const Icon(Icons.refresh_outlined),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        IconButton(
          onPressed: () => _onRunQuery(context),
          tooltip: 'Run Query',
          icon: const Icon(Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: editorNotifier.clear,
          tooltip: 'Clear Editor',
          icon: const Icon(Icons.clear_rounded),
        ),
      ],
      child: Column(
        children: <Widget>[
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(styles: githubTheme),
              child: CodeField(
                controller: editorNotifier.controller,
                focusNode: editorNotifier.focusNode,
                textStyle: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                ),
                gutterStyle: GutterStyle(width: 60.0, margin: 0.0),
                expands: true,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
          ),
          if (suggestionsNotifier.useBasicSuggestions)
            SqlBasicSuggestionsBarWidget(
              onInsertCommand: editorNotifier.insertCommand,
              filterText: editorNotifier.lastWord,
            ),
          if (suggestionsNotifier.useAdvancedSuggestions)
            SqlAdvancedSuggestionsBarWidget(
              onInsertCommand: editorNotifier.insertCommand,
            ),
          if (suggestionsNotifier.useCharacterSuggestions)
            SqlCharacterBarWidget(
              onInsertCommand: editorNotifier.insertCommand,
            ),
        ],
      ),
    );
  }
}
