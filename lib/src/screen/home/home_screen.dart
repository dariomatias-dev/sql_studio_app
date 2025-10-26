import 'package:flutter/material.dart';

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
      return _buildSinglePanel(
        title: 'SQL Editor',
        color: Colors.grey.shade100,
        onExitFullScreen: _toggleEditorMaximize,
        body: const EditorBody(),
      );
    }

    if (_consoleMaximized) {
      return _buildSinglePanel(
        title: 'Console / Query Results',
        color: Colors.grey.shade200,
        onExitFullScreen: _toggleConsoleMaximize,
        body: const ConsoleBody(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            flex: (_editorHeightFraction * 100).toInt(),
            child: _Panel(
              backgroundColor: Colors.grey.shade100,
              title: 'SQL Editor',
              onFullScreen: _toggleEditorMaximize,
              body: const EditorBody(),
            ),
          ),
          _DividerBar(
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
            child: _Panel(
              backgroundColor: Colors.grey.shade200,
              title: 'Console',
              onFullScreen: _toggleConsoleMaximize,
              body: const ConsoleBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinglePanel({
    required String title,
    required Color color,
    required VoidCallback onExitFullScreen,
    required Widget body,
  }) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _Panel(
        backgroundColor: color,
        title: title,
        onFullScreen: onExitFullScreen,
        isFullScreen: true,
        body: body,
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final VoidCallback onFullScreen;
  final bool isFullScreen;
  final Widget body;

  const _Panel({
    required this.backgroundColor,
    required this.title,
    required this.onFullScreen,
    this.isFullScreen = false,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          _PanelHeader(
            title: title,
            isFullScreen: isFullScreen,
            onFullScreen: onFullScreen,
          ),
          Expanded(
            child: Container(color: Colors.white, child: body),
          ),
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final String title;
  final bool isFullScreen;
  final VoidCallback onFullScreen;

  const _PanelHeader({
    required this.title,
    required this.isFullScreen,
    required this.onFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
          onPressed: onFullScreen,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _DividerBar extends StatelessWidget {
  final GestureDragUpdateCallback onDragUpdate;

  const _DividerBar({required this.onDragUpdate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: onDragUpdate,
      child: Container(
        height: 12,
        color: Colors.grey.shade300,
        child: Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

class EditorBody extends StatelessWidget {
  const EditorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Editor Body Widget'));
  }
}

class ConsoleBody extends StatelessWidget {
  const ConsoleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Console Body Widget'));
  }
}
