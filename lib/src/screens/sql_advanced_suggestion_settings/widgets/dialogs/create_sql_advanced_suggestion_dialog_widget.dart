import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/sql_advanced_suggestion_form_dialog_widget.dart';

class CreateSqlAdvancedSuggestionDialogWidget extends StatefulWidget {
  const CreateSqlAdvancedSuggestionDialogWidget({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const CreateSqlAdvancedSuggestionDialogWidget();
      },
    );
  }

  @override
  State<CreateSqlAdvancedSuggestionDialogWidget> createState() =>
      _CreateSqlAdvancedSuggestionDialogWidgetState();
}

class _CreateSqlAdvancedSuggestionDialogWidgetState
    extends State<CreateSqlAdvancedSuggestionDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SqlAdvancedSuggestionFormDialogWidget(
      title: appLocalizations.createSuggestion,
      submitText: appLocalizations.create,
      onSubmit: (value) async {
        final notifier = context.read<SqlAdvancedSuggestionsNotifier>();
        final result = await notifier.addSuggestion(value);

        if (!mounted) return false;

        Fluttertoast.showToast(
          msg: result.isSuccess
              ? appLocalizations.advancedSuggestionAdded
              : appLocalizations.advancedSuggestionFailed,
        );

        return result.isSuccess;
      },
    );
  }
}
