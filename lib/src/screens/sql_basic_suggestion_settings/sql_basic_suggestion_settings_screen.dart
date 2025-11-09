import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/sql_basic_suggestion_card/sql_basic_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_widget.dart';

class SqlBasicSuggestionsSettingsScreen extends StatefulWidget {
  const SqlBasicSuggestionsSettingsScreen({super.key});

  @override
  State<SqlBasicSuggestionsSettingsScreen> createState() =>
      _SqlBasicSuggestionsSettingsScreenState();
}

class _SqlBasicSuggestionsSettingsScreenState
    extends State<SqlBasicSuggestionsSettingsScreen> {
  late final _controller = SqlBasicSuggestionsController(context);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlBasicSuggestionsNotifier>();

    return SuggestionsSettingsLayoutWidget<String>(
      title: 'SQL Command Settings',
      isLoading: notifier.isLoading,
      initialItems: notifier.suggestions,
      itemBuilder: (suggestion, index) {
        return SqlBasicSuggestionCardWidget(
          key: ValueKey(suggestion),
          suggestion: suggestion,
        );
      },
      onReset: _controller.showResetConfirmationDialog,
      onAdd: _controller.showCreateCommandDialog,
      onSave: _controller.saveOrder,
    );
  }
}
