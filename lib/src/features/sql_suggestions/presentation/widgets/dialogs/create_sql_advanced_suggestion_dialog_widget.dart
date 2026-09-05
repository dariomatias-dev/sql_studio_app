import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

/// Dialog form for creating a new advanced SQL suggestion.
class CreateSqlAdvancedSuggestionDialogWidget extends ConsumerStatefulWidget {
  /// Creates the create-suggestion dialog widget.
  const CreateSqlAdvancedSuggestionDialogWidget({super.key});

  /// Displays the create-suggestion dialog above [context].
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const CreateSqlAdvancedSuggestionDialogWidget();
      },
    );
  }

  @override
  ConsumerState<CreateSqlAdvancedSuggestionDialogWidget> createState() =>
      _CreateSqlAdvancedSuggestionDialogWidgetState();
}

class _CreateSqlAdvancedSuggestionDialogWidgetState
    extends ConsumerState<CreateSqlAdvancedSuggestionDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

    return SqlAdvancedSuggestionFormDialogWidget(
      title: appLocalizations.createSuggestion,
      submitText: appLocalizations.create,
      onSubmit: (value) async {
        final viewModel = ref.read(
          sqlAdvancedSuggestionsViewModelProvider.notifier,
        );
        final result = await viewModel.addSuggestion(value);

        if (!mounted) return false;

        unawaited(
          toast.show(
            result.isSuccess
                ? appLocalizations.advancedSuggestionAdded
                : appLocalizations.advancedSuggestionFailed,
          ),
        );

        return result.isSuccess;
      },
    );
  }
}
