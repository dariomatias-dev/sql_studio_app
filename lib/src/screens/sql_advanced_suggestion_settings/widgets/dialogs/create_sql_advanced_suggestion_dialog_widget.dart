import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';

import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';

class CreateSqlAdvancedSuggestionDialogWidget extends StatefulWidget {
  const CreateSqlAdvancedSuggestionDialogWidget({super.key});

  @override
  State<CreateSqlAdvancedSuggestionDialogWidget> createState() =>
      _CreateSqlAdvancedSuggestionDialogWidgetState();
}

class _CreateSqlAdvancedSuggestionDialogWidgetState
    extends State<CreateSqlAdvancedSuggestionDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return SqlAdvancedSuggestionFormDialogWidget(
      title: 'Create Advanced Suggestion',
      submitText: 'Create',
      onSubmit: (value) async {
        final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
        final success = await notifier.addSuggestion(value);

        if (!mounted) return false;

        SnackBarUtils.show(
          _getContext(),
          success
              ? 'Suggestion added successfully.'
              : 'Failed to add suggestion.',
        );

        return success;
      },
    );
  }
}
