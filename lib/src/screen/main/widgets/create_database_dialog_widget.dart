import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialog_widget.dart';

class CreateDatabaseDialogWidget extends StatefulWidget {
  const CreateDatabaseDialogWidget({super.key});

  @override
  State<CreateDatabaseDialogWidget> createState() =>
      _CreateDatabaseDialogWidgetState();
}

class _CreateDatabaseDialogWidgetState
    extends State<CreateDatabaseDialogWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: 'Create Database',
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Database Name',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        CancelButtonWidget(),
        ButtonWidget(
          text: 'Create',
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
