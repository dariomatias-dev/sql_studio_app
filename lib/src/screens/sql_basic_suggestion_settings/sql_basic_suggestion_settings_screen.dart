import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/sql_basic_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout_widget.dart';

class SqlBasicSuggestionsSettingsScreen extends StatefulWidget {
  const SqlBasicSuggestionsSettingsScreen({super.key});

  @override
  State<SqlBasicSuggestionsSettingsScreen> createState() =>
      _SqlBasicSuggestionsSettingsScreenState();
}

class _SqlBasicSuggestionsSettingsScreenState
    extends State<SqlBasicSuggestionsSettingsScreen> {
  late final controller = SqlBasicSuggestionsController(context);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlBasicSuggestionsNotifier>();

    return SuggestionsSettingsLayoutWidget<String>(
      title: 'SQL Command Settings',
      isLoading: false,
      items: controller.getSuggestions(notifier),
      onReorder: (oldIndex, newIndex) {
        controller.reorderSuggestions(
          notifier,
          controller.getSuggestions(notifier),
          oldIndex,
          newIndex,
        );
      },
      itemBuilder: (cmd, index) {
        return SqlBasicSuggestionCardWidget(
          key: ValueKey(cmd),
          command: cmd,
          onDelete: () => controller.showRemoveCommandDialog(command: cmd),
        );
      },
      onReset: controller.showResetConfirmationDialog,
      onAdd: controller.showCreateCommandDialog,
      onSave: () async {},
    );
  }
}
