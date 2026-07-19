import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

/// Confirmation dialog for resetting all advanced SQL suggestions to their
/// default set.
class ResetSqlAdvancedSuggestionsDialogWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.resetSuggestions,
      description: appLocalizations.resetSuggestionsConfirm,
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          Navigator.pop(context);

          final notifier = context.read<SqlAdvancedSuggestionsNotifier>();

          final result = await notifier.resetSuggestions();

          unawaited(
            Fluttertoast.showToast(
              msg: result.isSuccess
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
