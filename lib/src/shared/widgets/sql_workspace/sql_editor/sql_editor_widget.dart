import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_controller.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_basic_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_character_bar_widget.dart';

/// Code editor panel where the user writes and runs SQL queries, including
/// its toolbar actions and suggestion bars.
class SqlEditorWidget extends ConsumerStatefulWidget {
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
  ConsumerState<SqlEditorWidget> createState() => _SqlEditorWidgetState();
}

class _SqlEditorWidgetState extends ConsumerState<SqlEditorWidget> {
  final _controller = SqlEditorController();

  void _onInsertCommand(String code, {String? selectText}) {
    _controller.onInsertCommand(ref, code, selectText: selectText);
  }

  PopupMenuItem<void> _sectionHeader(String label) {
    return PopupMenuItem<void>(
      enabled: false,
      height: 28,
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: AppColors.textMuted,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final commandsState = ref.watch(sqlCommandsViewModelProvider);
    final suggestionsSettings = ref.watch(
      sqlSuggestionSettingsViewModelProvider,
    );
    final editor = ref.watch(sqlEditorViewModelProvider.notifier);
    final editorState = ref.watch(sqlEditorViewModelProvider);
    final databaseName = commandsState.activeDatabase;

    final currentQueryItems = <PopupMenuItem<void>>[];
    final databaseItems = <PopupMenuItem<void>>[];

    if (commandsState.activeDatabase != null) {
      currentQueryItems.addAll([
        PopupMenuItem<void>(
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);

              await _controller.onCopySql(context, ref);
            },
            child: Row(
              children: <Widget>[
                const Icon(Icons.copy_rounded, size: 20),
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

              await _controller.onShareSql(context, ref);
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
            onTap: () async {
              Navigator.pop(context);

              await _controller.onDownloadSql(context, ref);
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

      databaseItems.add(
        PopupMenuItem<void>(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);

              AppRoutes.goToDatabaseVisualizer(context, dbName: databaseName!);
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
      );
    }

    if (commandsState.isDefaultDatabase) {
      databaseItems.add(
        PopupMenuItem<void>(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              unawaited(
                ref.read(sqlCommandsViewModelProvider.notifier).resetDatabase(),
              );
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

    final menuItems = <PopupMenuEntry<void>>[
      if (currentQueryItems.isNotEmpty) ...[
        _sectionHeader(appLocalizations.currentQuerySection),
        ...currentQueryItems,
      ],
      if (databaseItems.isNotEmpty) ...[
        if (currentQueryItems.isNotEmpty) const PopupMenuDivider(),
        _sectionHeader(appLocalizations.databaseSection),
        ...databaseItems,
      ],
    ];

    return PanelWidget(
      title: widget.showTitle ? appLocalizations.editor : null,
      databaseName: databaseName,
      onFullScreen: widget.onFullScreen,
      isFullScreen: widget.isFullScreen,
      actions: <Widget>[
        IconButton(
          onPressed: () => _controller.onLoadLastSql(context, ref),
          tooltip: appLocalizations.loadLastSql,
          icon: const Icon(Icons.undo),
        ),
        IconButton(
          onPressed: () =>
              _controller.onRunQuery(context, ref, widget.onQueryRun),
          tooltip: appLocalizations.runQuery,
          icon: const Icon(Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: editor.clear,
          tooltip: appLocalizations.clearEditor,
          icon: const Icon(Icons.clear_rounded),
        ),
        if (menuItems.isNotEmpty)
          PopupMenuButtonWidget(
            items: menuItems,
            onOpened: editor.focusNode.unfocus,
          ),
      ],
      child: Column(
        children: <Widget>[
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(styles: githubTheme),
              child: CodeField(
                controller: editor.controller,
                focusNode: editor.focusNode,
                textStyle: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                gutterStyle: const GutterStyle(width: 60, margin: 0),
                expands: true,
                decoration: const BoxDecoration(color: AppColors.white),
              ),
            ),
          ),
          if (suggestionsSettings.useBasicSuggestions)
            SqlBasicSuggestionsBarWidget(
              onInsertCommand: _onInsertCommand,
              filterText: editorState.lastWord,
            ),
          if (suggestionsSettings.useAdvancedSuggestions)
            SqlAdvancedSuggestionsBarWidget(onInsertCommand: _onInsertCommand),
          if (suggestionsSettings.useCharacterSuggestions)
            SqlCharacterBarWidget(onInsertCommand: _onInsertCommand),
        ],
      ),
    );
  }
}
