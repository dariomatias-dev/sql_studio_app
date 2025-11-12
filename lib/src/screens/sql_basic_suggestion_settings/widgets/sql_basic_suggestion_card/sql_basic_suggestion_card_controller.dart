import 'package:flutter/material.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/remove_sql_basic_suggestion_dialog_widget.dart';

class SqlBasicSuggestionCardController {
  final BuildContext context;
  final String suggestion;

  SqlBasicSuggestionCardController({
    required this.context,
    required this.suggestion,
  });

  void showRemoveCommandDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return RemoveSqlBasicSuggestionDialogWidget(suggestion: suggestion);
      },
    );
  }
}
