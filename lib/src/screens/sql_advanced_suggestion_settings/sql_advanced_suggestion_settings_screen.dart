import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_card/sql_advanced_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout_widget.dart';

class SqlAdvancedSuggestionSettingsScreen extends StatefulWidget {
  const SqlAdvancedSuggestionSettingsScreen({super.key});

  @override
  State<SqlAdvancedSuggestionSettingsScreen> createState() =>
      _SqlAdvancedSuggestionSettingsScreenState();
}

class _SqlAdvancedSuggestionSettingsScreenState
    extends State<SqlAdvancedSuggestionSettingsScreen> {
  late final _controller = SqlAdvancedSuggestionsController(context);

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchNotifier = context.watch<SqlAdvancedSuggestionsNotifier>();

    return ValueListenableBuilder<List<SqlAdvancedSuggestionModel>>(
      valueListenable: _controller.suggestionsOrderNotifier,
      builder: (context, suggestions, child) {
        return SuggestionsSettingsLayoutWidget<SqlAdvancedSuggestionModel>(
          title: 'Advanced Suggestions',
          isLoading: watchNotifier.isLoading,
          items: suggestions,
          onReorder: _controller.reorderSuggestions,
          itemBuilder: (suggestion, index) {
            return SqlAdvancedSuggestionCardWidget(
              key: ValueKey(suggestion.id),
              suggestion: suggestion,
            );
          },
          onReset: _controller.showResetDialog,
          onAdd: _controller.showCreateDialog,
          onSave: _controller.saveOrder,
        );
      },
    );
  }
}
