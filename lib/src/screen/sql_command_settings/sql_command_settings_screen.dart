import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/constants/sql_commands.dart';

import 'package:sql_studio/src/shared/widgets/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialog_widget.dart';

class SqlCommandSettingsScreen extends StatefulWidget {
  const SqlCommandSettingsScreen({super.key});

  @override
  State<SqlCommandSettingsScreen> createState() =>
      _SqlCommandSettingsScreenState();
}

class _SqlCommandSettingsScreenState extends State<SqlCommandSettingsScreen> {
  late List<String> _commands;

  void _removeCommand(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: 'Remove Command',
          content: const Text(
            'Are you sure you want to remove this command?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CancelButtonWidget(),
            ButtonWidget(
              text: 'Remove',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderColor: Colors.red,
              onPressed: () {
                setState(() => _commands.removeAt(index));

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _commands = List<String>.from(sqlCommands);
  }

  @override
  Widget build(BuildContext context) {
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
          'Configurar Comandos SQL',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100.0),
        ),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {},
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
          itemCount: _commands.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final item = _commands.removeAt(oldIndex);
              _commands.insert(newIndex, item);
            });
          },
          itemBuilder: (context, index) {
            final cmd = _commands[index];

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
                  onPressed: () => _removeCommand(index),
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
