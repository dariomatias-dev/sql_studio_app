import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';

/// Handles user actions triggered from the SQL editor toolbar, such as
/// running, sharing, and copying the current query text.
class SqlEditorController {
  /// Runs the current editor content as a SQL query and invokes
  /// [onQueryRun] afterwards, if provided.
  void onRunQuery(BuildContext context, VoidCallback? onQueryRun) {
    final notifier = context.read<SqlCommandsNotifier>();
    final editorNotifier = context.read<SqlEditorNotifier>();
    final sql = editorNotifier.controller.text.trim();

    if (sql.isEmpty) return;

    unawaited(notifier.runQuery(sql));

    if (onQueryRun != null) onQueryRun();
  }

  /// Inserts [value] at the current cursor position in the SQL editor,
  /// focusing it first if needed, and optionally selecting [selectText].
  void onInsertCommand(
    BuildContext context,
    String value, {
    String? selectText,
  }) {
    final focusNode = context.read<SqlEditorNotifier>().focusNode;
    if (!focusNode.hasFocus) {
      focusNode.requestFocus();
    }

    context.read<SqlEditorNotifier>().insertCommand(
      value,
      selectText: selectText,
    );
  }

  /// Shares the current editor content as text using the platform share
  /// sheet, showing a toast if there is nothing to share.
  Future<void> onShareSql(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context)!;

    final sql = context.read<SqlEditorNotifier>().controller.text.trim();

    if (sql.isEmpty) {
      unawaited(Fluttertoast.showToast(msg: appLocalizations.nothingToShare));

      return;
    }

    final result = await SharePlus.instance.share(ShareParams(text: sql));

    if (result.status == ShareResultStatus.success) {
      unawaited(Fluttertoast.showToast(msg: appLocalizations.sqlSharedSuccess));
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Copies the current editor content to the clipboard, showing a toast
  /// with the outcome.
  Future<void> onCopySql(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context)!;

    final sql = context.read<SqlEditorNotifier>().controller.text.trim();

    if (sql.isEmpty) {
      unawaited(Fluttertoast.showToast(msg: appLocalizations.nothingToCopy));
      return;
    }

    await Clipboard.setData(ClipboardData(text: sql));

    unawaited(Fluttertoast.showToast(msg: appLocalizations.sqlCopied));

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
