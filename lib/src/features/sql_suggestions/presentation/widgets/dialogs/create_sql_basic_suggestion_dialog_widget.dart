import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/input_dialog_widget.dart';

/// Dialog for creating a new basic SQL suggestion.
class CreateSqlBasicSuggestionDialogWidget extends ConsumerStatefulWidget {
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
  ConsumerState<CreateSqlBasicSuggestionDialogWidget> createState() =>
      _CreateSqlBasicSuggestionDialogWidgetState();
}

class _CreateSqlBasicSuggestionDialogWidgetState
    extends ConsumerState<CreateSqlBasicSuggestionDialogWidget> {
  final _controller = TextEditingController();

  BuildContext _getContext() => context;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

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
        final result = await ref
            .read(sqlBasicSuggestionsViewModelProvider.notifier)
            .add(value);

        if (!mounted) return result.isSuccess;

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
