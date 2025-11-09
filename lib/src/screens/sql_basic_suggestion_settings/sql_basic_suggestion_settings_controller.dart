import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/create_basic_command_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/reset_confirmation_dialog_widget.dart';

class SqlBasicSuggestionsController {
  final BuildContext context;

  SqlBasicSuggestionsController(this.context) {
    notifier = context.read<SqlBasicSuggestionsNotifier>();
  }

  late final SqlBasicSuggestionsNotifier notifier;

  Future<void> saveOrder(List<String> suggestions) async {
    notifier.updateSuggestions(suggestions);
  }

  void showCreateCommandDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateBasicCommandSuggestionDialogWidget(),
    );
  }

  void showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => const ResetConfirmationDialogWidget(),
    );
  }
}
