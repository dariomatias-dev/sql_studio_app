import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class ResetSqlBasicSuggestionsDialogWidget extends StatefulWidget {
  const ResetSqlBasicSuggestionsDialogWidget({super.key});

  @override
  State<ResetSqlBasicSuggestionsDialogWidget> createState() =>
      _ResetSqlBasicSuggestionsDialogWidgetState();
}

class _ResetSqlBasicSuggestionsDialogWidgetState
    extends State<ResetSqlBasicSuggestionsDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialogWidget(
      title: 'Reset Suggestions',
      description: 'Are you sure you want to reset the suggestion list?',
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final result = await context
              .read<SqlBasicSuggestionsNotifier>()
              .updateSuggestions(List<String>.from(defaultSqlBasicSuggestions));

          if (result.isSuccess) {
            _getContext().pop();
          } else {
            handleError(_getContext(), result);
          }
        },
        text: 'Reset',
        style: ButtonStyleType.black,
      ),
    );
  }
}
