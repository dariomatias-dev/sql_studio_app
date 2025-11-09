import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/reset_sql_advanced_suggestions_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class SqlAdvancedSuggestionsController {
  final BuildContext context;

  SqlAdvancedSuggestionsController(this.context) {
    notifier = context.read<SqlAdvancedSuggestionsNotifier>();
  }

  late final SqlAdvancedSuggestionsNotifier notifier;

  Future<void> saveOrder(List<SqlAdvancedSuggestionModel> suggestions) async {
    await notifier.reorderSuggestions(suggestions);
  }

  void showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateSqlAdvancedSuggestionDialogWidget(),
    );
  }

  void showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => const ResetSqlAdvancedSuggestionsDialogWidget(),
    );
  }
}
