import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/widgets/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

class CreateDatabaseDialogWidget extends StatefulWidget {
  const CreateDatabaseDialogWidget({super.key});

  @override
  State<CreateDatabaseDialogWidget> createState() =>
      _CreateDatabaseDialogWidgetState();
}

class _CreateDatabaseDialogWidgetState
    extends State<CreateDatabaseDialogWidget> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String _toSnakeCase(String input) {
    return input
        .trim()
        .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .toLowerCase();
  }

  void _createDatabase() {
    if (!formKey.currentState!.validate()) return;

    final snakeName = _toSnakeCase(controller.text);
    final database = DatabaseModel(label: controller.text, name: snakeName);

    debugPrint(database.toString());

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: 'Create Database',
      content: Form(
        key: formKey,
        child: InputWidget(
          controller: controller,
          labelText: 'Database Name',
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a database name';
            }
            if (!RegExp(r'^[a-zA-Z0-9 _-]+$').hasMatch(value)) {
              return 'Invalid characters detected';
            }

            return null;
          },
        ),
      ),
      actions: <Widget>[
        const CancelButtonWidget(),
        ButtonWidget(
          text: 'Create',
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: _createDatabase,
        ),
      ],
    );
  }
}
