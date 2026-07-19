import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/routes/app_routes.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_controller.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_basic_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_character_bar_widget.dart';

/// Code editor panel where the user writes and runs SQL queries, including
/// its toolbar actions and suggestion bars.
class SqlEditorWidget extends StatefulWidget {
  /// Creates the SQL editor panel.
  const SqlEditorWidget({
    super.key,
    this.showTitle = true,
    this.isFullScreen,
    this.onFullScreen,
    this.onQueryRun,
  });

  /// Whether the panel title should be displayed.
  final bool showTitle;

  /// Whether the panel is currently expanded to full screen.
  final bool? isFullScreen;

  /// Called when the full screen toggle button is pressed.
  final VoidCallback? onFullScreen;

  /// Called after a query has been submitted for execution.
  final VoidCallback? onQueryRun;

  @override
  State<SqlEditorWidget> createState() => _SqlEditorWidgetState();
}

class _SqlEditorWidgetState extends State<SqlEditorWidget> {
  final _controller = SqlEditorController();

  void _onInsertCommand(String code, {String? selectText}) {
    _controller.onInsertCommand(context, code, selectText: selectText);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final sqlCommandsNotifier = context.watch<SqlCommandsNotifier>();
    final suggestionsNotifier = context.watch<SqlSuggestionsNotifier>();
    final editorNotifier = context.watch<SqlEditorNotifier>();
    final databaseName = sqlCommandsNotifier.activeDatabase;

    return PanelWidget(
      title: widget.showTitle ? appLocalizations.editor : null,
      databaseName: databaseName,
      onFullScreen: widget.onFullScreen,
      isFullScreen: widget.isFullScreen,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          tooltip: appLocalizations.loadLastSql,
          icon: const Icon(Icons.undo),
        ),
        IconButton(
          onPressed: () => _controller.onRunQuery(context, widget.onQueryRun),
          tooltip: appLocalizations.runQuery,
          icon: const Icon(Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: editorNotifier.clear,
          tooltip: appLocalizations.clearEditor,
          icon: const Icon(Icons.clear_rounded),
        ),
        Consumer<SqlCommandsNotifier>(
          builder: (context, notifier, child) {
            final menuItems = <PopupMenuItem<void>>[];

            if (notifier.activeDatabase != null) {
              menuItems.addAll([
                PopupMenuItem<void>(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      AppRoutes.goToDatabaseVisualizer(
                        context,
                        dbName: databaseName!,
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.remove_red_eye_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(appLocalizations.viewVisualScheme),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<void>(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);

                      await _controller.onCopySql(context);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.share, size: 20),
                        const SizedBox(width: 8),
                        Text(appLocalizations.copySql),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<void>(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);

                      await _controller.onShareSql(context);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.share, size: 20),
                        const SizedBox(width: 8),
                        Text(appLocalizations.shareSql),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<void>(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.download, size: 20),
                        const SizedBox(width: 8),
                        Text(appLocalizations.downloadSql),
                      ],
                    ),
                  ),
                ),
              ]);
            }

            if (notifier.isDefaultDatabase) {
              menuItems.add(
                PopupMenuItem<void>(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      unawaited(notifier.resetDatabase());
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.refresh_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(appLocalizations.resetDatabase),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (menuItems.isEmpty) {
              return const SizedBox.shrink();
            }

            return PopupMenuButtonWidget(items: menuItems);
          },
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
                  fontSize: 14,
                ),
                gutterStyle: const GutterStyle(width: 60, margin: 0),
                expands: true,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
          ),
          if (suggestionsNotifier.useBasicSuggestions)
            SqlBasicSuggestionsBarWidget(
              onInsertCommand: _onInsertCommand,
              filterText: editorNotifier.lastWord,
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
