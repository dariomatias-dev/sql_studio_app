import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class RemoveSqlBasicSuggestionDialogWidget extends StatefulWidget {
  const RemoveSqlBasicSuggestionDialogWidget({
    super.key,
    required this.suggestion,
  });

  final String suggestion;

  static Future<void> show(
    BuildContext context, {
    required String suggestion,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return RemoveSqlBasicSuggestionDialogWidget(suggestion: suggestion);
      },
    );
  }

  @override
  State<RemoveSqlBasicSuggestionDialogWidget> createState() =>
      _RemoveSqlBasicSuggestionDialogWidgetState();
}

class _RemoveSqlBasicSuggestionDialogWidgetState
    extends State<RemoveSqlBasicSuggestionDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.removeSuggestion,
      description: appLocalizations.removeSuggestionDescription,
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final result = await context
              .read<SqlBasicSuggestionsNotifier>()
              .remove(widget.suggestion);

          if (result.isFailure) {
            handleError(_getContext(), result);

            return;
          }

          _getContext().pop();
        },
        text: appLocalizations.remove,
        style: ButtonStyleType.red,
      ),
    );
  }
}
