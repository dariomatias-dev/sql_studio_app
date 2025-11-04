import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/types/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_form_dialog_widget.dart';

class CreateSqlAdvancedSuggestionDialogWidget extends StatelessWidget {
  const CreateSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.onSubmit,
  });

  final Future<bool> Function(SqlAdvancedSuggestionModel value) onSubmit;

  @override
  Widget build(BuildContext context) {
    return SqlAdvancedSuggestionFormDialogWidget(
      title: 'Create Advanced Suggestion',
      submitText: 'Create',
      onSubmit: onSubmit,
    );
  }
}
