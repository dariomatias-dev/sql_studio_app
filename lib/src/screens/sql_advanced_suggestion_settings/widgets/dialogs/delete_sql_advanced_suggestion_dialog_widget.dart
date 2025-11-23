import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DeleteSqlAdvancedSuggestionDialogWidget extends StatelessWidget {
  const DeleteSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.id,
    required this.label,
  });

  final String id;
  final String label;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.removeSuggestion,
      description:
          appLocalizations.deleteSuggestionConfirmation(label),
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
          final result = await notifier.removeSuggestion(id);

          Fluttertoast.showToast(
            msg: result.isSuccess
                ? appLocalizations.suggestionDeleted
                : appLocalizations.suggestionDeleteFailed,
          );

          if (context.mounted) Navigator.pop(context);
        },
        text: appLocalizations.delete,
        style: ButtonStyleType.red,
      ),
    );
  }
}
