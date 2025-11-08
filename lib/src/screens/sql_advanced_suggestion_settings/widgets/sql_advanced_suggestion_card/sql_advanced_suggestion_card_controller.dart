import 'package:flutter/material.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/delete_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/update_sql_advanced_suggestion_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class SqlAdvancedSuggestionCardController {
  final BuildContext context;
  final SqlAdvancedSuggestionModel suggestion;

  SqlAdvancedSuggestionCardController({
    required this.context,
    required this.suggestion,
  });

  void showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateSqlAdvancedSuggestionDialogWidget(
          initialValue: suggestion,
        );
      },
    );
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteSqlAdvancedSuggestionDialogWidget(
          id: suggestion.id,
          label: suggestion.label,
        );
      },
    );
  }
}
