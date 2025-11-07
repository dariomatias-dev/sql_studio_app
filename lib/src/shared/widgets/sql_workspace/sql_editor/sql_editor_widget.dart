import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/sql.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_character_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_basic_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart';

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

  String _lastWord = '';

  void _onRunQuery() {
    final sql = _controller.text.trim();

    if (sql.isEmpty) return;

    final notifier = context.read<SqlCommandsNotifier>();

    notifier.runQuery(sql);

    if (widget.onQueryRun != null) {
      widget.onQueryRun!();
    }
  }

  void _onInsertCommand(String command, {String? selectText}) {
    final text = _controller.text;
    final selection = _controller.selection;

    if (text.isEmpty) {
      setState(() {
        _controller.text = command;
        _controller.selection = TextSelection.collapsed(offset: command.length);
      });
      return;
    }

    final before = text.substring(0, selection.start);
    final after = text.substring(selection.end);

    final regex = RegExp(r'(\b\w+)$');
    final match = regex.firstMatch(before);
    final start = match != null ? match.start : selection.start;

    final newText = before.replaceRange(start, before.length, command) + after;

    setState(() {
      _controller.text = newText;
      _controller.selection = TextSelection.collapsed(
        offset: start + command.length,
      );
    });
  }

  void _onClearEditor() {
    setState(() {
      _controller.text = '';
      _lastWord = '';
    });
  }

  void _onTextChanged() {
    final text = _controller.text;
    final lastWord = text.split(RegExp(r'\s+')).last.trim();
    if (_lastWord != lastWord) {
      setState(() {
        _lastWord = lastWord;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sqlCommandsNotifier = context.watch<SqlCommandsNotifier>();
    final suggestionsNotifier = context.watch<SqlSuggestionsNotifier>();
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
          onPressed: _onRunQuery,
          tooltip: 'Run Query',
          icon: const Icon(Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: _onClearEditor,
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
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
          ),
          if (suggestionsNotifier.useBasicSuggestions)
            SqlBasicSuggestionsBarWidget(
              onInsertCommand: _onInsertCommand,
              filterText: _lastWord,
            ),
          if (suggestionsNotifier.useAdvancedSuggestions)
            SqlAdvancedSuggestionsBarWidget(onInsertCommand: _onInsertCommand),
          if (suggestionsNotifier.useCharacterSuggestions)
            SqlCharacterBarWidget(onInsertCommand: _onInsertCommand),
        ],
      ),
    );
  }
}
