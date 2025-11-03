import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/sql.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/character_suggestions_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_command_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_quick_suggestions_bar_widget.dart';

class SqlEditorWidget extends StatefulWidget {
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

  @override
  State<SqlEditorWidget> createState() => _SqlEditorStateSqlEditorWidget();
}

class _SqlEditorStateSqlEditorWidget extends State<SqlEditorWidget> {
  final _controller = CodeController(language: sql);

  void _runQuery() {
    final sql = _controller.text.trim();
    if (sql.isEmpty) return;

    final notifier = context.read<SqlCommandsNotifier>();

    notifier.runQuery(sql);

    if (widget.onQueryRun != null) {
      widget.onQueryRun!();
    }
  }

  void _clearEditor() {
    setState(() {
      _controller.text = '';
    });
  }

  void _insertCommand(String command, {String? selectText}) {
    final text = _controller.text;
    var selection = _controller.selection;

    if (selection.start < 0 || selection.end < 0) {
      selection = TextSelection.collapsed(offset: text.length);
    }

    final newText = text.replaceRange(selection.start, selection.end, command);

    setState(() {
      _controller.text = newText;

      if (selectText != null) {
        final start = newText.indexOf(selectText, selection.start);
        if (start != -1) {
          _controller.selection = TextSelection(
            baseOffset: start,
            extentOffset: start + selectText.length,
          );
          return;
        }
      }

      _controller.selection = TextSelection.collapsed(
        offset: selection.start + command.length,
      );
    });
  }

  void _onTextChanged(String value) {
    final word = value.split(RegExp(r'\s+')).last.toUpperCase();

    context.read<SqlSuggestionsNotifier>().updateSuggestions(word);
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => _onTextChanged(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final sqlCommandsNotifier = context.watch<SqlCommandsNotifier>();
    final databaseName = sqlCommandsNotifier.activeDatabase;

    return PanelWidget(
      title: widget.showTitle ? 'Editor' : null,
      databaseName: databaseName,
      onFullScreen: widget.onFullScreen,
      isFullScreen: widget.isFullScreen,
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
          onPressed: _runQuery,
          tooltip: 'Run Query',
          icon: const Icon(Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: _clearEditor,
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
                controller: _controller,
                textStyle: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                ),
                gutterStyle: GutterStyle(width: 60.0, margin: 0.0),
                expands: true,
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
          ),
          SqlCommandBarWidget(onInsertCommand: _insertCommand),
          SqlQuickSuggestionsBarWidget(onInsertCommand: _insertCommand),
          CharacterSuggestionsWidget(onInsertCommand: _insertCommand),
        ],
      ),
    );
  }
}
