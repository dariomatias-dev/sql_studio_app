import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class ResetSqlAdvancedSuggestionsDialogWidget extends StatefulWidget {
  const ResetSqlAdvancedSuggestionsDialogWidget({super.key});

  @override
  State<ResetSqlAdvancedSuggestionsDialogWidget> createState() =>
      _ResetSqlAdvancedSuggestionsDialogWidgetState();
}

class _ResetSqlAdvancedSuggestionsDialogWidgetState
    extends State<ResetSqlAdvancedSuggestionsDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Reset Suggestions',
      description: 'Are you sure you want to reset all advanced suggestions?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          if (!mounted) return;

          Navigator.pop(context);

          final notifier = context.read<SqlAdvancedSuggestionsNotifier>();

          final result = await notifier.resetSuggestions();

          if (!mounted) return;

          SnackBarUtils.show(
            _getContext(),
            result.isSuccess
                ? 'All advanced suggestions have been successfully reset.'
                : 'Failed to reset advanced suggestions. Please try again.',
          );
        },
        text: 'Ok',
        style: ButtonStyleType.black,
      ),
    );
  }
}
