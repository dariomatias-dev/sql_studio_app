import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/create_basic_command_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/remove_basic_command_suggestion_dialog_widget.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class SqlBasicSuggestionsSettingsScreen extends StatefulWidget {
  const SqlBasicSuggestionsSettingsScreen({super.key});

  @override
  State<SqlBasicSuggestionsSettingsScreen> createState() =>
      _SqlBasicSuggestionsSettingsScreenState();
}

class _SqlBasicSuggestionsSettingsScreenState
    extends State<SqlBasicSuggestionsSettingsScreen> {
  final controller = TextEditingController();

  late final notifier = Provider.of<SqlBasicSuggestionsNotifier>(context);

  BuildContext _getContext() => context;

  void _showCreateCommandDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateBasicCommandSuggestionDialogWidget();
      },
    );
  }

  void _showRemoveCommandDialog(String command) {
    showDialog(
      context: context,
      builder: (context) {
        return RemoveBasicCommandSuggestionDialogWidget(command: command);
      },
    );
  }

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialogWidget(
          title: 'Reset Commands',
          description: 'Are you sure you want to reset the command list?',
          confirmButton: LoadingButtonWidget(
            onPressed: () async {
              await notifier.updateSuggestions(
                List<String>.from(defaultSqlBasicSuggestions),
              );

              _getContext().pop();
            },
            text: 'Reset',
            style: ButtonStyleType.black,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commands = List<String>.from(
      notifier.suggestions.isEmpty
          ? defaultSqlBasicSuggestions
          : notifier.suggestions,
    );

    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('SQL Command Settings'),
        actions: <Widget>[
          IconButton(
            onPressed: _showResetConfirmationDialog,
            icon: const Icon(Icons.refresh, color: Colors.black87),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateCommandDialog(),
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
            bottom: 100.0,
            left: 12.0,
          ),
          itemCount: commands.length,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final item = commands.removeAt(oldIndex);

            commands.insert(newIndex, item);

            notifier.updateSuggestions(commands);
          },
          itemBuilder: (context, index) {
            final cmd = commands[index];
            return Container(
              key: ValueKey(cmd),
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withAlpha(25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 6.0,
                ),
                leading: const Icon(Icons.drag_handle, color: Colors.black54),
                title: Text(
                  cmd.trim(),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () => _showRemoveCommandDialog(cmd),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
