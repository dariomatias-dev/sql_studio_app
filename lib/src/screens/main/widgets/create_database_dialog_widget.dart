import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/input_dialog_widget.dart';

class CreateDatabaseDialogWidget extends StatefulWidget {
  const CreateDatabaseDialogWidget({super.key, required this.onCreated});

  final ValueChanged<DatabaseModel> onCreated;

  @override
  State<CreateDatabaseDialogWidget> createState() =>
      _CreateDatabaseDialogWidgetState();
}

class _CreateDatabaseDialogWidgetState
    extends State<CreateDatabaseDialogWidget> {
  final controller = TextEditingController();

  String _toSnakeCase(String input) {
    return input
        .trim()
        .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .toLowerCase();
  }

  Future<void> _createDatabase(String value) async {
    final snakeName = _toSnakeCase(value);
    final database = DatabaseModel(label: value, name: snakeName);

    widget.onCreated(database);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputDialogWidget(
      title: 'Create Database',
      controller: controller,
      label: 'Database Name',
      submitText: 'Create',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a database name';
        } else if (!RegExp(r'^[a-zA-Z0-9 _-]+$').hasMatch(value)) {
          return 'Invalid characters detected';
        }

        return null;
      },
      onSubmit: _createDatabase,
    );
  }
}
