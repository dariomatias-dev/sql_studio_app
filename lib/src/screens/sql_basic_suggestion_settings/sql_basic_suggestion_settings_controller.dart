import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/create_sql_basic_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/reset_sql_basic_suggestions_dialog_widget.dart';

class SqlBasicSuggestionsController {
  final BuildContext Function() getContext;

  SqlBasicSuggestionsController({required this.getContext}) {
    notifier = getContext().read<SqlBasicSuggestionsNotifier>();
  }

  late final SqlBasicSuggestionsNotifier notifier;

  Future<bool> saveOrder(List<String> suggestions) async {
    final result = await notifier.updateSuggestions(suggestions);

    return result.isSuccess;
  }

  void showCreateCommandDialog() {
    showDialog(
      context: getContext(),
      builder: (context) => const CreateSqlBasicSuggestionDialogWidget(),
    );
  }

  void showResetConfirmationDialog() {
    showDialog(
      context: getContext(),
      builder: (context) => const ResetSqlBasicSuggestionsDialogWidget(),
    );
  }
}
