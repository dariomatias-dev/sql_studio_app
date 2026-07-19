import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/reset_sql_advanced_suggestions_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_widget.dart';

/// Screen for managing the user's advanced SQL suggestions: listing,
/// creating, reordering, and resetting them.
class SqlAdvancedSuggestionSettingsScreen extends ConsumerStatefulWidget {
  /// Creates the advanced SQL suggestions settings screen.
  const SqlAdvancedSuggestionSettingsScreen({super.key});

  @override
  ConsumerState<SqlAdvancedSuggestionSettingsScreen> createState() =>
      _SqlAdvancedSuggestionSettingsScreenState();
}

class _SqlAdvancedSuggestionSettingsScreenState
    extends ConsumerState<SqlAdvancedSuggestionSettingsScreen> {
  late final _controller = SqlAdvancedSuggestionsController(ref: ref);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sqlAdvancedSuggestionsViewModelProvider);

    return SuggestionsSettingsLayoutWidget<SqlAdvancedSuggestionModel>(
      title: AppLocalizations.of(context)!.advancedSuggestions,
      isLoading: state.isLoading,
      initialItems: state.suggestions,
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
