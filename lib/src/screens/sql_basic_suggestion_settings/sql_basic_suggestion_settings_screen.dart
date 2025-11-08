import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/sql_basic_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

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
    final commands = controller.getSuggestions(notifier);

    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('SQL Command Settings'),
        actions: <Widget>[
          IconButton(
            onPressed: controller.showResetConfirmationDialog,
            icon: const Icon(Icons.refresh, color: Colors.black87),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showCreateCommandDialog,
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: ReorderableListView.builder(
          padding: const EdgeInsets.only(
            top: 8.0,
            right: 12.0,
            bottom: 80.0,
            left: 12.0,
          ),
          itemCount: commands.length,
          onReorder: (oldIndex, newIndex) {
            controller.reorderSuggestions(
              notifier,
              commands,
              oldIndex,
              newIndex,
            );
          },
          itemBuilder: (context, index) {
            final cmd = commands[index];

            return SqlBasicSuggestionCardWidget(
              key: ValueKey(cmd),
              command: cmd,
              onDelete: () => controller.showRemoveCommandDialog(command: cmd),
            );
          },
        ),
      ),
    );
  }
}
