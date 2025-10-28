import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/widgets/dialogs/input_dialog_widget.dart';

class CreateCommandDialogWidget extends StatefulWidget {
  const CreateCommandDialogWidget({super.key});

  @override
  State<CreateCommandDialogWidget> createState() =>
      _CreateCommandDialogWidgetState();
}

class _CreateCommandDialogWidgetState extends State<CreateCommandDialogWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputDialogWidget(
      title: 'Create Command',
      controller: _controller,
      label: 'Command Name',
      submitText: 'Create',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter a command name';
        } else if (!RegExp(r'^[a-zA-Z0-9 _-]+$').hasMatch(value)) {
          return 'Invalid characters';
        }

        return null;
      },
      onSubmit: (value) async {
        await context.read<SqlCommandsNotifier>().addCommand(value);

        _controller.text = '';
      },
    );
  }
}
