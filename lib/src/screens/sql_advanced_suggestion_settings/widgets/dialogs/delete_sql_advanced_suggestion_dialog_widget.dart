import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

/// Confirmation dialog for deleting an existing advanced SQL suggestion.
class DeleteSqlAdvancedSuggestionDialogWidget extends ConsumerWidget {
  /// Creates the delete-confirmation dialog for the suggestion identified
  /// by [id] and displayed as [label].
  const DeleteSqlAdvancedSuggestionDialogWidget({
    required this.id,
    required this.label,
    super.key,
  });

  /// Identifier of the suggestion to delete.
  final String id;

  /// Display label of the suggestion, shown in the confirmation message.
  final String label;

  /// Displays the delete-confirmation dialog above [context] for the
  /// suggestion identified by [id] and displayed as [label].
  static Future<void> show(
    BuildContext context, {
    required String id,
    required String label,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return DeleteSqlAdvancedSuggestionDialogWidget(id: id, label: label);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.removeSuggestion,
      description: appLocalizations.deleteSuggestionConfirmation(label),
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final viewModel = ref.read(
            sqlAdvancedSuggestionsViewModelProvider.notifier,
          );
          final result = await viewModel.removeSuggestion(id);

          unawaited(
            Fluttertoast.showToast(
              msg: result.isSuccess
                  ? appLocalizations.suggestionDeleted
                  : appLocalizations.suggestionDeleteFailed,
            ),
          );

          if (context.mounted) Navigator.pop(context);
        },
        text: appLocalizations.delete,
        style: ButtonStyleType.red,
      ),
    );
  }
}
