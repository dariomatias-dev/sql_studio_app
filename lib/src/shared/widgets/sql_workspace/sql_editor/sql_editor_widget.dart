import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';

import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';
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
  State<SqlEditorWidget> createState() => _SqlEditorWidgetState();
}

class _SqlEditorWidgetState extends State<SqlEditorWidget> {
  void _onRunQuery() {
    final notifier = context.read<SqlCommandsNotifier>();
    final editorNotifier = context.read<SqlEditorNotifier>();
    final sql = editorNotifier.controller.text.trim();

    if (sql.isEmpty) return;

    notifier.runQuery(sql);

    if (widget.onQueryRun != null) widget.onQueryRun!();
  }

  void _onInsertCommand(String value, {String? selectText}) {
    final focusNode = context.read<SqlEditorNotifier>().focusNode;
    if (!focusNode.hasFocus) {
      focusNode.requestFocus();
    }

    context.read<SqlEditorNotifier>().insertCommand(
      value,
      selectText: selectText,
    );
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
          onPressed: _onRunQuery,
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
            final menuItems = <PopupMenuItem>[];

            if (notifier.activeDatabase != null) {
              menuItems.add(
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      context.push(
                        RouteNames.databaseVisualizer(databaseName!),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.remove_red_eye_outlined, size: 20.0),
                        const SizedBox(width: 8.0),
                        Text(appLocalizations.viewVisualScheme),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (notifier.isDefaultDatabase) {
              menuItems.add(
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      notifier.resetDatabase();
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.refresh_outlined, size: 20.0),
                        const SizedBox(width: 8.0),
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
