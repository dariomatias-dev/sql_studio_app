import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/shared/utils/app_toast.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

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
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.resetSuggestions,
      description: appLocalizations.resetSuggestionsConfirm,
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          Navigator.pop(context);

          final viewModel = ref.read(
            sqlAdvancedSuggestionsViewModelProvider.notifier,
          );

          final result = await viewModel.resetSuggestions();

          unawaited(
            AppToast.show(
              result.isSuccess
                  ? appLocalizations.suggestionsResetSuccess
                  : appLocalizations.suggestionsResetFailed,
            ),
          );
        },
        text: 'Ok',
        style: ButtonStyleType.black,
      ),
    );
  }
}
