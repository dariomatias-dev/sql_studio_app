import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

/// Handles user actions triggered from the SQL editor toolbar, such as
/// running, sharing, and copying the current query text.
class SqlEditorController {
  /// Creates the controller, sharing through [_sharePlus].
  SqlEditorController({SharePlus? sharePlus})
    : _sharePlus = sharePlus ?? SharePlus.instance;

  final SharePlus _sharePlus;

  /// Runs the current editor content as a SQL query and invokes
  /// [onQueryRun] afterwards, if provided.
  void onRunQuery(
    BuildContext context,
    WidgetRef ref,
    VoidCallback? onQueryRun,
  ) {
    final commands = ref.read(sqlCommandsViewModelProvider.notifier);
    final editor = ref.read(sqlEditorViewModelProvider.notifier);
    final sql = editor.controller.text.trim();

    if (sql.isEmpty) return;

    FocusManager.instance.primaryFocus?.unfocus();

    unawaited(commands.runQuery(sql));

    if (onQueryRun != null) onQueryRun();
  }

  /// Inserts [value] at the current cursor position in the SQL editor,
  /// focusing it first if needed, and optionally selecting [selectText].
  void onInsertCommand(
    WidgetRef ref,
    String value, {
    String? selectText,
  }) {
    final editor = ref.read(sqlEditorViewModelProvider.notifier);

    if (!editor.focusNode.hasFocus) {
      editor.focusNode.requestFocus();
    }

    editor.insertCommand(value, selectText: selectText);
  }

  /// Shares the current editor content as text using the platform share
  /// sheet, showing a toast if there is nothing to share.
  Future<void> onShareSql(BuildContext context, WidgetRef ref) async {
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

    final sql = ref
        .read(sqlEditorViewModelProvider.notifier)
        .controller
        .text
        .trim();

    if (sql.isEmpty) {
      unawaited(toast.show(appLocalizations.nothingToShare));

      return;
    }

    final result = await _sharePlus.share(ShareParams(text: sql));

    if (result.status == ShareResultStatus.success) {
      unawaited(toast.show(appLocalizations.sqlSharedSuccess));
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Copies the current editor content to the clipboard, showing a toast
  /// with the outcome.
  Future<void> onCopySql(BuildContext context, WidgetRef ref) async {
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

    final sql = ref
        .read(sqlEditorViewModelProvider.notifier)
        .controller
        .text
        .trim();

    if (sql.isEmpty) {
      unawaited(toast.show(appLocalizations.nothingToCopy));
      return;
    }

    await Clipboard.setData(ClipboardData(text: sql));

    unawaited(toast.show(appLocalizations.sqlCopied));

    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Saves the current editor content as a `.sql` file through the
  /// platform's save/share sheet, showing a toast if there is nothing to
  /// download.
  Future<void> onDownloadSql(BuildContext context, WidgetRef ref) async {
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

    final sql = ref
        .read(sqlEditorViewModelProvider.notifier)
        .controller
        .text
        .trim();

    if (sql.isEmpty) {
      unawaited(toast.show(appLocalizations.nothingToDownload));

      return;
    }

    final file = XFile.fromData(
      Uint8List.fromList(utf8.encode(sql)),
      name: 'query.sql',
      mimeType: 'text/plain',
    );

    final result = await _sharePlus.share(
      ShareParams(files: [file]),
    );

    if (result.status == ShareResultStatus.success) {
      unawaited(toast.show(appLocalizations.sqlDownloaded));
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Restores the text of the last executed query into the editor, showing
  /// a toast if there is no previous query to load.
  void onLoadLastSql(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

    final lastQuery = ref.read(sqlCommandsViewModelProvider).lastQuery;

    if (lastQuery == null || lastQuery.isEmpty) {
      unawaited(toast.show(appLocalizations.nothingToLoad));

      return;
    }

    ref.read(sqlEditorViewModelProvider.notifier).controller.text = lastQuery;

    unawaited(toast.show(appLocalizations.lastSqlLoaded));
  }
}
