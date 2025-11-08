import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/create_basic_command_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/remove_basic_command_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/reset_confirmation_dialog_widget.dart';

class SqlBasicSuggestionsController {
  final BuildContext context;

  SqlBasicSuggestionsController(this.context);

  List<String> getSuggestions(SqlBasicSuggestionsNotifier notifier) {
    return List<String>.from(
      notifier.suggestions.isEmpty
          ? defaultSqlBasicSuggestions
          : notifier.suggestions,
    );
  }

  void reorderSuggestions(
    SqlBasicSuggestionsNotifier notifier,
    List<String> commands,
    int oldIndex,
    int newIndex,
  ) {
    if (newIndex > oldIndex) newIndex--;
    final item = commands.removeAt(oldIndex);
    commands.insert(newIndex, item);
    notifier.updateSuggestions(commands);
  }

  void showCreateCommandDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const CreateBasicCommandSuggestionDialogWidget();
      },
    );
  }

  void showRemoveCommandDialog({required String command}) {
    showDialog(
      context: context,
      builder: (context) {
        return RemoveBasicCommandSuggestionDialogWidget(command: command);
      },
    );
  }

  void showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const ResetConfirmationDialogWidget();
      },
    );
  }
}
