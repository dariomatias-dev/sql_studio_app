import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/notifiers/workspace_layout_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/divider_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart';

class SqlWorkspaceWidget extends StatefulWidget {
  const SqlWorkspaceWidget({super.key});

  @override
  State<SqlWorkspaceWidget> createState() => _SqlWorkspaceWidgetState();
}

class _SqlWorkspaceWidgetState extends State<SqlWorkspaceWidget>
    with TickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  double _editorHeightFraction = 0.66;
  bool _editorMaximized = false;
  bool _consoleMaximized = false;

  double get _screenHeight => MediaQuery.sizeOf(context).height;

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
    final layoutType = context.watch<WorkspaceLayoutNotifier>().selectedLayout;

    if (layoutType == WorkspaceLayoutType.tabs) {
      return Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              tabs: const <Tab>[
                Tab(text: 'Editor'),
                Tab(text: 'Console'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                SqlEditorWidget(
                  showTitle: false,
                  onQueryRun: () {
                    if (_tabController.index != 1) {
                      _tabController.animateTo(1);
                    }
                  },
                ),

                ConsoleWidget(showTitle: false),
              ],
            ),
          ),
        ],
      );
    }

    if (_editorMaximized) {
      return SqlEditorWidget(
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

    return Column(
      children: <Widget>[
        Flexible(
          flex: (_editorHeightFraction * 100).toInt(),
          child: SqlEditorWidget(
            isFullScreen: _editorMaximized,
            onFullScreen: _toggleEditorMaximize,
          ),
        ),
        DividerBarWidget(
          onDragUpdate: (details) {
            setState(() {
              final delta = details.delta.dy / _screenHeight;
              _editorHeightFraction = (_editorHeightFraction + delta).clamp(
                2 / 5,
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
    );
  }
}
