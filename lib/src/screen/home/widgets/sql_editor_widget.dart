import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/sql.dart';

import 'package:sql_studio/src/screen/home/widgets/panel_widget.dart';

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

  void _runQuery() {
    final sql = _controller.text.trim();
    if (sql.isEmpty) return;
  }

  void _clearEditor() {
    setState(() {
      _controller.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return PanelWidget(
      title: 'SQL Editor',
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CodeTheme(
                data: const CodeThemeData(styles: githubTheme),
                child: CodeField(
                  controller: _controller,
                  expands: true,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14.0,
                  ),
                  background: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
