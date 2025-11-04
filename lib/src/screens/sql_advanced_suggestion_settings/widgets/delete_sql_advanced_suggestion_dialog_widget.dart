import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DeleteSqlAdvancedSuggestionDialogWidget extends StatelessWidget {
  const DeleteSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.label,
    required this.onConfirm,
  });

  final String label;
  final Future<void> Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Remove Suggestion',
      description: 'Are you sure you want to delete the suggestion "$label"?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          await onConfirm();
          if (context.mounted) Navigator.pop(context);
        },
        text: 'Delete',
        style: ButtonStyleType.red,
      ),
    );
  }
}
