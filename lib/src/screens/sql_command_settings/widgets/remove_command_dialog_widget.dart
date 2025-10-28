import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class RemoveCommandDialogWidget extends StatefulWidget {
  const RemoveCommandDialogWidget({super.key, required this.command});

  final String command;

  @override
  State<RemoveCommandDialogWidget> createState() =>
      _RemoveCommandDialogWidgetState();
}

class _RemoveCommandDialogWidgetState extends State<RemoveCommandDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Remove Command',
      description: 'Are you sure you want to remove this command?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          await context.read<SqlCommandsNotifier>().removeCommand(
            widget.command,
          );

          _getContext().pop();
        },
        text: 'Remove',
        style: ButtonStyleType.red,
      ),
    );
  }
}
