import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/features/workspace_layout_settings/presentation/providers.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/divider_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart';

/// Combines the SQL editor and console panels into a single workspace,
/// arranged either as a resizable split view or as tabs depending on the
/// selected layout.
class SqlWorkspaceWidget extends ConsumerStatefulWidget {
  /// Creates the SQL workspace.
  const SqlWorkspaceWidget({super.key});

  @override
  ConsumerState<SqlWorkspaceWidget> createState() => _SqlWorkspaceWidgetState();
}

class _SqlWorkspaceWidgetState extends ConsumerState<SqlWorkspaceWidget>
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
    final layoutType = ref.watch(workspaceLayoutViewModelProvider);

    if (layoutType == WorkspaceLayoutType.tabs) {
      return Column(
        children: <Widget>[
          ColoredBox(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: AppColors.textMuted,
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

                const ConsoleWidget(showTitle: false),
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
