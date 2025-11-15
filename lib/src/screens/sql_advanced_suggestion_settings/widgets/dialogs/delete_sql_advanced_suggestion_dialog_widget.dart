import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DeleteSqlAdvancedSuggestionDialogWidget extends StatefulWidget {
  const DeleteSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.id,
    required this.label,
  });

  final String id;
  final String label;

  @override
  State<DeleteSqlAdvancedSuggestionDialogWidget> createState() =>
      _DeleteSqlAdvancedSuggestionDialogWidgetState();
}

class _DeleteSqlAdvancedSuggestionDialogWidgetState
    extends State<DeleteSqlAdvancedSuggestionDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Remove Suggestion',
      description:
          'Are you sure you want to delete the suggestion "${widget.label}"?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
          final result = await notifier.removeSuggestion(widget.id);

          if (!mounted) return;

          Fluttertoast.showToast(
            msg: result.isSuccess
                ? 'Suggestion deleted successfully.'
                : 'Failed to delete suggestion.',
          );

          if (context.mounted) Navigator.pop(context);
        },
        text: 'Delete',
        style: ButtonStyleType.red,
      ),
    );
  }
}
