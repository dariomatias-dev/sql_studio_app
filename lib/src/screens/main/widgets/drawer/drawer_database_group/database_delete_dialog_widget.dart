import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DatabaseDeleteDialogWidget extends StatelessWidget {
  const DatabaseDeleteDialogWidget({
    super.key,
    required this.onDeleteDatabase,
  });

  final VoidCallback onDeleteDatabase;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Attention',
      description:
          'Are you sure you want to permanently delete this database? This action cannot be undone.',
      confirmButton: ButtonWidget(
        onPressed: onDeleteDatabase,
        text: 'Delete',
        style: ButtonStyleType.red,
      ),
    );
  }
}
