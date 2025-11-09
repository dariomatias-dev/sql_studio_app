import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/create_basic_command_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/reset_confirmation_dialog_widget.dart';

class SqlBasicSuggestionsController {
  final BuildContext context;

  SqlBasicSuggestionsController(this.context) {
    notifier = context.read<SqlBasicSuggestionsNotifier>();

    _updateSuggestionsOrder();

    notifier.addListener(_updateSuggestionsOrder);
  }

  late final SqlBasicSuggestionsNotifier notifier;

  final suggestionsOrderNotifier = ValueNotifier<List<String>>([]);

  void _updateSuggestionsOrder() {
    suggestionsOrderNotifier.value = List<String>.from(
      notifier.suggestions.isEmpty
          ? defaultSqlBasicSuggestions
          : notifier.suggestions,
    );
  }

  void reorderSuggestions(
    int oldIndex,
    int newIndex,
  ) {
    final updated = <String>[...suggestionsOrderNotifier.value];

    if (newIndex > oldIndex) newIndex--;

    final item = updated.removeAt(oldIndex);

    updated.insert(newIndex, item);

    suggestionsOrderNotifier.value = updated;
  }

  Future<void> saveOrder() async {
    notifier.updateSuggestions(suggestionsOrderNotifier.value);
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

  void dispose() {
    notifier.removeListener(_updateSuggestionsOrder);

    suggestionsOrderNotifier.dispose();
  }
}
