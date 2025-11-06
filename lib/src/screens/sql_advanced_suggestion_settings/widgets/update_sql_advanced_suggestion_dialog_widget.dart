import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_form_dialog_widget.dart';

import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';

class UpdateSqlAdvancedSuggestionDialogWidget extends StatefulWidget {
  const UpdateSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.initialValue,
  });

  final SqlAdvancedSuggestionModel initialValue;

  @override
  State<UpdateSqlAdvancedSuggestionDialogWidget> createState() =>
      _UpdateSqlAdvancedSuggestionDialogWidgetState();
}

class _UpdateSqlAdvancedSuggestionDialogWidgetState
    extends State<UpdateSqlAdvancedSuggestionDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return SqlAdvancedSuggestionFormDialogWidget(
      title: 'Update Advanced Suggestion',
      submitText: 'Update',
      initialValue: widget.initialValue,
      onSubmit: (value) async {
        final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
        final success = await notifier.updateSuggestion(value);

        if (!mounted) return false;

        SnackBarUtils.show(
          _getContext(),
          success
              ? 'Suggestion updated successfully.'
              : 'Failed to update suggestion.',
        );

        return success;
      },
    );
  }
}
