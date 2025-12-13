import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';

class SqlEditorController {
  void onRunQuery(BuildContext context, VoidCallback? onQueryRun) {
    final notifier = context.read<SqlCommandsNotifier>();
    final editorNotifier = context.read<SqlEditorNotifier>();
    final sql = editorNotifier.controller.text.trim();

    if (sql.isEmpty) return;

    notifier.runQuery(sql);

    if (onQueryRun != null) onQueryRun();
  }

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

  Future<void> onShareSql(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context)!;

    final sql = context.read<SqlEditorNotifier>().controller.text.trim();

    if (sql.isEmpty) {
      Fluttertoast.showToast(msg: appLocalizations.nothingToShare);

      return;
    }

    final result = await SharePlus.instance.share(ShareParams(text: sql));

    if (result.status == ShareResultStatus.success) {
      Fluttertoast.showToast(msg: appLocalizations.sqlSharedSuccess);
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> onCopySql(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context)!;

    final sql = context.read<SqlEditorNotifier>().controller.text.trim();

    if (sql.isEmpty) {
      Fluttertoast.showToast(msg: appLocalizations.nothingToCopy);
      return;
    }

    await Clipboard.setData(ClipboardData(text: sql));

    Fluttertoast.showToast(msg: appLocalizations.sqlCopied);

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
