import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/reset_sql_advanced_suggestions_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_card/sql_advanced_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_widget.dart';

class SqlAdvancedSuggestionSettingsScreen extends StatefulWidget {
  const SqlAdvancedSuggestionSettingsScreen({super.key});

  @override
  State<SqlAdvancedSuggestionSettingsScreen> createState() =>
      _SqlAdvancedSuggestionSettingsScreenState();
}

class _SqlAdvancedSuggestionSettingsScreenState
    extends State<SqlAdvancedSuggestionSettingsScreen> {
  late final _controller = SqlAdvancedSuggestionsController(
    getContext: _getContext,
  );

  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlAdvancedSuggestionsNotifier>();

    return SuggestionsSettingsLayoutWidget<SqlAdvancedSuggestionModel>(
      title: AppLocalizations.of(context)!.advancedSuggestions,
      isLoading: notifier.isLoading,
      initialItems: notifier.suggestions,
      itemBuilder: (suggestion, index) {
        return SqlAdvancedSuggestionCardWidget(
          key: ValueKey(suggestion.id),
          suggestion: suggestion,
        );
      },
      onReset: () => ResetSqlAdvancedSuggestionsDialogWidget.show(context),
      onAdd: () => CreateSqlAdvancedSuggestionDialogWidget.show(context),
      onSave: _controller.saveOrder,
    );
  }
}
