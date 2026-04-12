import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DatabaseDeleteDialogWidget extends StatelessWidget {
  const DatabaseDeleteDialogWidget({super.key, required this.onDeleteDatabase});

  final VoidCallback onDeleteDatabase;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onDeleteDatabase,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return DatabaseDeleteDialogWidget(onDeleteDatabase: onDeleteDatabase);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.attention,
      description: appLocalizations.deleteDatabaseConfirmation,
      confirmButton: ButtonWidget(
        onPressed: onDeleteDatabase,
        text: appLocalizations.delete,
        style: ButtonStyleType.red,
      ),
    );
  }
}
