import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return SqlAdvancedSuggestionFormDialogWidget(
      title: 'Update Advanced Suggestion',
      submitText: 'Update',
      initialValue: widget.initialValue,
      onSubmit: (value) async {
        final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
        final result = await notifier.updateSuggestion(value);

        if (!mounted) return false;

        Fluttertoast.showToast(
          msg: result.isSuccess
              ? 'Suggestion updated successfully.'
              : 'Failed to update suggestion.',
        );

        return result.isSuccess;
      },
    );
  }
}
