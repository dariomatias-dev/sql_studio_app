import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';

/// Dialog form for updating an existing advanced SQL suggestion.
class UpdateSqlAdvancedSuggestionDialogWidget extends ConsumerWidget {
  /// Creates the update-suggestion dialog, prefilled with [initialValue].
  const UpdateSqlAdvancedSuggestionDialogWidget({
    required this.initialValue,
    super.key,
  });

  /// Suggestion being edited, used to prefill the form.
  final SqlAdvancedSuggestionModel initialValue;

  /// Displays the update-suggestion dialog above [context], prefilled with
  /// [initialValue].
  static Future<void> show(
    BuildContext context, {
    required SqlAdvancedSuggestionModel initialValue,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return UpdateSqlAdvancedSuggestionDialogWidget(
          initialValue: initialValue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SqlAdvancedSuggestionFormDialogWidget(
      title: appLocalizations.updateSuggestion,
      submitText: appLocalizations.update,
      initialValue: initialValue,
      onSubmit: (value) async {
        final viewModel = ref.read(
          sqlAdvancedSuggestionsViewModelProvider.notifier,
        );
        final result = await viewModel.updateSuggestion(value);

        unawaited(
          Fluttertoast.showToast(
            msg: result.isSuccess
                ? appLocalizations.updateSuggestionSuccess
                : appLocalizations.updateSuggestionFail,
          ),
        );

        return result.isSuccess;
      },
    );
  }
}
