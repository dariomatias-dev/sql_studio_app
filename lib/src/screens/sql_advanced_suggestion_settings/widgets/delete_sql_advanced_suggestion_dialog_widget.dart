import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DeleteSqlAdvancedSuggestionDialogWidget extends StatefulWidget {
  const DeleteSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.suggestionId,
    required this.label,
  });

  final String suggestionId;
  final String label;

  @override
  State<DeleteSqlAdvancedSuggestionDialogWidget> createState() =>
      _DeleteSqlAdvancedSuggestionDialogWidgetState();
}

class _DeleteSqlAdvancedSuggestionDialogWidgetState
    extends State<DeleteSqlAdvancedSuggestionDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Remove Suggestion',
      description:
          'Are you sure you want to delete the suggestion "${widget.label}"?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
          final success = await notifier.removeSuggestion(widget.suggestionId);

          if (!mounted) return;

          SnackBarUtils.show(
            _getContext(),
            success
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
