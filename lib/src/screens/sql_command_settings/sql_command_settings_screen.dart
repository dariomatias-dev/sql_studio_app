import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/sql_commands.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_command_settings/widgets/create_command_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_command_settings/widgets/remove_command_dialog_widget.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class SqlCommandSettingsScreen extends StatefulWidget {
  const SqlCommandSettingsScreen({super.key});

  @override
  State<SqlCommandSettingsScreen> createState() =>
      _SqlCommandSettingsScreenState();
}

class _SqlCommandSettingsScreenState extends State<SqlCommandSettingsScreen> {
  final controller = TextEditingController();

  late final notifier = Provider.of<SqlSuggestionsNotifier>(context);

  BuildContext _getContext() => context;

  void _showCreateCommandDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateCommandDialogWidget();
      },
    );
  }

  void _showRemoveCommandDialog(String command) {
    showDialog(
      context: context,
      builder: (context) {
        return RemoveCommandDialogWidget(command: command);
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
              await notifier.updateCommands(List<String>.from(sqlCommands));

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
      notifier.commands.isEmpty ? sqlCommands : notifier.commands,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 24.0,
          ),
        ),
        title: const Text(
          'SQL Command Settings',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
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
            notifier.updateCommands(commands);
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
