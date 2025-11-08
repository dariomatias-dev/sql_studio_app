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

    _updateSuggestionsOrder();

    notifier.addListener(_updateSuggestionsOrder);
  }

  late final SqlAdvancedSuggestionsNotifier notifier;

  final suggestionsOrderNotifier = ValueNotifier(
    <SqlAdvancedSuggestionModel>[],
  );

  void _updateSuggestionsOrder() {
    suggestionsOrderNotifier.value = List<SqlAdvancedSuggestionModel>.from(
      notifier.advancedSuggestions,
    );
  }

  Future<void> saveOrder() async {
    await notifier.reorderSuggestions(suggestionsOrderNotifier.value);
  }

  void reorderSuggestions(
    List<SqlAdvancedSuggestionModel> suggestions,
    int oldIndex,
    int newIndex,
  ) {
    final updated = <SqlAdvancedSuggestionModel>[...suggestions];

    if (newIndex > oldIndex) newIndex--;

    final item = updated.removeAt(oldIndex);

    updated.insert(newIndex, item);

    suggestionsOrderNotifier.value = updated;
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

  void dispose() {
    notifier.removeListener(_updateSuggestionsOrder);

    suggestionsOrderNotifier.dispose();
  }
}
