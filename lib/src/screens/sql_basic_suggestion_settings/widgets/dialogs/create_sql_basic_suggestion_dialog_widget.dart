import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/input_dialog_widget.dart';

class CreateSqlBasicSuggestionDialogWidget extends StatefulWidget {
  const CreateSqlBasicSuggestionDialogWidget({super.key});

  @override
  State<CreateSqlBasicSuggestionDialogWidget> createState() =>
      _CreateSqlBasicSuggestionDialogWidgetState();
}

class _CreateSqlBasicSuggestionDialogWidgetState
    extends State<CreateSqlBasicSuggestionDialogWidget> {
  final _controller = TextEditingController();

  BuildContext _getContext() => context;

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
        final result = await context.read<SqlBasicSuggestionsNotifier>().add(
          value,
        );

        if (result.isFailure) {
          handleError(_getContext(), result);
        } else {
          _controller.text = '';
        }

        return result.isSuccess;
      },
    );
  }
}
