import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/types/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_form_dialog_widget.dart';

class UpdateSqlAdvancedSuggestionDialogWidget extends StatelessWidget {
  const UpdateSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.initialValue,
    required this.onSubmit,
  });

  final SqlAdvancedSuggestionModel initialValue;
  final Future<bool> Function(SqlAdvancedSuggestionModel value) onSubmit;

  @override
  Widget build(BuildContext context) {
    return SqlAdvancedSuggestionFormDialogWidget(
      title: 'Update Advanced Suggestion',
      submitText: 'Update',
      initialValue: initialValue,
      onSubmit: onSubmit,
    );
  }
}
