import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class RemoveBasicCommandSuggestionDialogWidget extends StatefulWidget {
  const RemoveBasicCommandSuggestionDialogWidget({super.key, required this.command});

  final String command;

  @override
  State<RemoveBasicCommandSuggestionDialogWidget> createState() =>
      _RemoveBasicCommandSuggestionDialogWidgetState();
}

class _RemoveBasicCommandSuggestionDialogWidgetState extends State<RemoveBasicCommandSuggestionDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Remove Command',
      description: 'Are you sure you want to remove this command?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          await context.read<SqlSuggestionsNotifier>().removeCommand(
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
