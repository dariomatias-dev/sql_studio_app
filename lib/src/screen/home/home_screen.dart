import 'package:flutter/material.dart';

import 'package:sql_studio/src/screen/home/widgets/console_widget.dart';
import 'package:sql_studio/src/screen/home/widgets/divider_bar_widget.dart';
import 'package:sql_studio/src/screen/home/widgets/sql_editor_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _editorHeightFraction = 0.66;
  bool _editorMaximized = false;
  bool _consoleMaximized = false;

  void _toggleEditorMaximize() {
    setState(() {
      _editorMaximized = !_editorMaximized;
      _consoleMaximized = false;
    });
  }

  void _toggleConsoleMaximize() {
    setState(() {
      _consoleMaximized = !_consoleMaximized;
      _editorMaximized = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    if (_editorMaximized) {
      return SqlEditor(
        isFullScreen: _editorMaximized,
        onFullScreen: _toggleEditorMaximize,
      );
    }

    if (_consoleMaximized) {
      return ConsoleWidget(
        isFullScreen: _consoleMaximized,
        onFullScreen: _toggleConsoleMaximize,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: (_editorHeightFraction * 100).toInt(),
            child: SqlEditor(
              isFullScreen: _editorMaximized,
              onFullScreen: _toggleEditorMaximize,
            ),
          ),
          DividerBar(
            onDragUpdate: (details) {
              setState(() {
                double delta = details.delta.dy / screenHeight;
                _editorHeightFraction = (_editorHeightFraction + delta).clamp(
                  0.1,
                  0.9,
                );
              });
            },
          ),
          Flexible(
            flex: ((1 - _editorHeightFraction) * 100).toInt(),
            child: ConsoleWidget(
              isFullScreen: _consoleMaximized,
              onFullScreen: _toggleConsoleMaximize,
            ),
          ),
        ],
      ),
    );
  }
}
