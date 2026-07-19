import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

/// Confirmation dialog shown before permanently deleting a database.
class DatabaseDeleteDialogWidget extends StatelessWidget {
  /// Creates the delete-database confirmation dialog.
  const DatabaseDeleteDialogWidget({required this.onDeleteDatabase, super.key});

  /// Called when the user confirms the deletion.
  final VoidCallback onDeleteDatabase;

  /// Displays the delete-database confirmation dialog on top of [context].
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onDeleteDatabase,
  }) async {
    await showDialog<void>(
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
