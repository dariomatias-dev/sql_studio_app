import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

import 'package:sql_studio/src/shared/utils/app_toast.dart';
import 'package:sql_studio/src/shared/widgets/buttons/cancel_button_widget.dart';

/// Confirmation dialog for resetting all advanced SQL suggestions to their
/// default set.
class ResetSqlAdvancedSuggestionsDialogWidget extends ConsumerWidget {
  /// Creates the reset-confirmation dialog widget.
  const ResetSqlAdvancedSuggestionsDialogWidget({super.key});

  /// Displays the reset-confirmation dialog above [context].
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const ResetSqlAdvancedSuggestionsDialogWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final toast = AppToast.of(context);

    return ConfirmationDialogWidget(
      title: appLocalizations.resetSuggestions,
      description: appLocalizations.resetSuggestionsConfirm,
      cancelButton: const CancelButtonWidget(),
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          Navigator.pop(context);

          final viewModel = ref.read(
            sqlAdvancedSuggestionsViewModelProvider.notifier,
          );

          final result = await viewModel.resetSuggestions();

          unawaited(
            toast.show(
              result.isSuccess
                  ? appLocalizations.suggestionsResetSuccess
                  : appLocalizations.suggestionsResetFailed,
            ),
          );
        },
        text: appLocalizations.ok,
        style: ButtonStyleType.black,
      ),
    );
  }
}
