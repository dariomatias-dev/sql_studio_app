import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/create_sql_basic_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/reset_sql_basic_suggestions_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/sql_basic_suggestion_card/sql_basic_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_widget.dart';

class SqlBasicSuggestionsSettingsScreen extends StatefulWidget {
  const SqlBasicSuggestionsSettingsScreen({super.key});

  @override
  State<SqlBasicSuggestionsSettingsScreen> createState() =>
      _SqlBasicSuggestionsSettingsScreenState();
}

class _SqlBasicSuggestionsSettingsScreenState
    extends State<SqlBasicSuggestionsSettingsScreen> {
  late final _controller = SqlBasicSuggestionsController(
    getContext: _getContext,
  );

  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlBasicSuggestionsNotifier>();

    return SuggestionsSettingsLayoutWidget<String>(
      title: AppLocalizations.of(context)!.basicSuggestions,
      isLoading: notifier.isLoading,
      initialItems: notifier.suggestions,
      itemBuilder: (suggestion, index) {
        return SqlBasicSuggestionCardWidget(
          key: ValueKey(suggestion),
          suggestion: suggestion,
        );
      },
      onReset: () => ResetSqlBasicSuggestionsDialogWidget.show(context),
      onAdd: () => CreateSqlBasicSuggestionDialogWidget.show(context),
      onSave: _controller.saveOrder,
    );
  }
}
