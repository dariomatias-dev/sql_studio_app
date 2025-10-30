import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/sql.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/screens/home/widgets/panel_widget.dart';
import 'package:sql_studio/src/screens/home/widgets/sql_editor/sql_command_bar_widget.dart';

class SqlEditorWidget extends StatefulWidget {
  const SqlEditorWidget({
    super.key,
    required this.isFullScreen,
    required this.onFullScreen,
  });

  final bool isFullScreen;
  final VoidCallback onFullScreen;

  @override
  State<SqlEditorWidget> createState() => _SqlEditorStateSqlEditorWidget();
}

class _SqlEditorStateSqlEditorWidget extends State<SqlEditorWidget> {
  final _controller = CodeController(language: sql);
  final _focusNode = FocusNode();

  void _runQuery() {
    final sql = _controller.text.trim();
    if (sql.isEmpty) return;

    final notifier = context.read<SqlCommandsNotifier>();
    notifier.runQuery(sql);
  }

  void _clearEditor() {
    setState(() {
      _controller.text = '';
    });
  }

  void _insertCommand(String command) {
    final text = _controller.text;
    var selection = _controller.selection;

    if (selection.start < 0 || selection.end < 0) {
      selection = TextSelection.collapsed(offset: text.length);
    }

    final newText = text.replaceRange(selection.start, selection.end, command);

    setState(() {
      _controller.text = newText;
      _controller.selection = TextSelection.collapsed(
        offset: selection.start + command.length,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.0);
    final databaseName = context.watch<SqlCommandsNotifier>().activeDatabase;

    return PanelWidget(
      title: 'SQL Editor',
      databaseName: databaseName,
      onFullScreen: widget.onFullScreen,
      isFullScreen: widget.isFullScreen,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.play_arrow_rounded),
          tooltip: 'Run Query',
          onPressed: _runQuery,
        ),
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          tooltip: 'Clear Editor',
          onPressed: _clearEditor,
        ),
      ],
      child: Column(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: borderRadius.topLeft,
                topRight: borderRadius.topRight,
              ),
              child: CodeTheme(
                data: const CodeThemeData(styles: githubTheme),
                child: CodeField(
                  controller: _controller,
                  focusNode: _focusNode,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14.0,
                  ),
                  background: Colors.white,
                ),
              ),
            ),
          ),
          SqlCommandBarWidget(onInsertCommand: _insertCommand),
        ],
      ),
    );
  }
}
