import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/input_dialog_widget.dart';

/// Dialog for creating a new basic SQL suggestion.
class CreateSqlBasicSuggestionDialogWidget extends StatefulWidget {
  /// Creates the dialog widget for adding a basic SQL suggestion.
  const CreateSqlBasicSuggestionDialogWidget({super.key});

  /// Displays this dialog on top of the given [context].
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const CreateSqlBasicSuggestionDialogWidget();
      },
    );
  }

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
    final appLocalizations = AppLocalizations.of(context)!;

    return InputDialogWidget(
      title: appLocalizations.createSuggestion,
      controller: _controller,
      label: appLocalizations.suggestionName,
      submitText: appLocalizations.create,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return appLocalizations.enterSuggestionName;
        } else if (!RegExp(r'^[a-zA-Z0-9 _-]+$').hasMatch(value)) {
          return appLocalizations.invalidCharacters;
        }

        return null;
      },
      onSubmit: (value) async {
        final result = await context.read<SqlBasicSuggestionsNotifier>().add(
          value,
        );

        if (result.isSuccess) {
          _controller.text = '';
        } else {
          await handleError(_getContext(), result);
        }

        return result.isSuccess;
      },
    );
  }
}
