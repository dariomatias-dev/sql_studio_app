import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/reset_sql_advanced_suggestions_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';

class SqlAdvancedSuggestionsController {
  final BuildContext Function() getContext;

  SqlAdvancedSuggestionsController({required this.getContext}) {
    notifier = getContext().read<SqlAdvancedSuggestionsNotifier>();
  }

  late final SqlAdvancedSuggestionsNotifier notifier;

  Future<bool> saveOrder(List<SqlAdvancedSuggestionModel> suggestions) async {
    await notifier.reorderSuggestions(suggestions);

    SnackBarUtils.show(getContext(), 'Suggestions saved successfully.');

    return true;
  }

  void showCreateDialog() {
    showDialog(
      context: getContext(),
      builder: (context) => const CreateSqlAdvancedSuggestionDialogWidget(),
    );
  }

  void showResetDialog() {
    showDialog(
      context: getContext(),
      builder: (context) => const ResetSqlAdvancedSuggestionsDialogWidget(),
    );
  }
}
