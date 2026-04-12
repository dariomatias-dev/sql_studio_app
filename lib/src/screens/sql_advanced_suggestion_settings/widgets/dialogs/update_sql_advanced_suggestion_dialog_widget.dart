import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class UpdateSqlAdvancedSuggestionDialogWidget extends StatelessWidget {
  const UpdateSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.initialValue,
  });

  final SqlAdvancedSuggestionModel initialValue;

  static Future<void> show(
    BuildContext context, {
    required SqlAdvancedSuggestionModel initialValue,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return UpdateSqlAdvancedSuggestionDialogWidget(
          initialValue: initialValue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SqlAdvancedSuggestionFormDialogWidget(
      title: appLocalizations.updateSuggestion,
      submitText: appLocalizations.update,
      initialValue: initialValue,
      onSubmit: (value) async {
        final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
        final result = await notifier.updateSuggestion(value);

        Fluttertoast.showToast(
          msg: result.isSuccess
              ? appLocalizations.updateSuggestionSuccess
              : appLocalizations.updateSuggestionFail,
        );

        return result.isSuccess;
      },
    );
  }
}
