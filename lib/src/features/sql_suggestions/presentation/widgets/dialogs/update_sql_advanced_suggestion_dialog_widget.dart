import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

/// Dialog form for updating an existing advanced SQL suggestion.
class UpdateSqlAdvancedSuggestionDialogWidget extends ConsumerWidget {
  /// Creates the update-suggestion dialog, prefilled with [initialValue].
  const UpdateSqlAdvancedSuggestionDialogWidget({
    required this.initialValue,
    super.key,
  });

  /// Suggestion being edited, used to prefill the form.
  final SqlAdvancedSuggestionEntity initialValue;

  /// Displays the update-suggestion dialog above [context], prefilled with
  /// [initialValue].
  static Future<void> show(
    BuildContext context, {
    required SqlAdvancedSuggestionEntity initialValue,
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
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

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
          toast.show(
            result.isSuccess
                ? appLocalizations.updateSuggestionSuccess
                : appLocalizations.updateSuggestionFail,
          ),
        );

        return result.isSuccess;
      },
    );
  }
}
