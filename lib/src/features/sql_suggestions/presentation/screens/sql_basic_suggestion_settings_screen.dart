import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/controllers/sql_basic_suggestion_settings_controller.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/create_sql_basic_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/reset_sql_basic_suggestions_dialog_widget.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/sql_basic_suggestion_card_widget.dart';
import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_widget.dart';

/// Screen that lets the user manage the list of basic SQL suggestions.
class SqlBasicSuggestionsSettingsScreen extends ConsumerStatefulWidget {
  /// Creates the basic SQL suggestions settings screen.
  const SqlBasicSuggestionsSettingsScreen({super.key});

  @override
  ConsumerState<SqlBasicSuggestionsSettingsScreen> createState() =>
      _SqlBasicSuggestionsSettingsScreenState();
}

class _SqlBasicSuggestionsSettingsScreenState
    extends ConsumerState<SqlBasicSuggestionsSettingsScreen> {
  late final _controller = SqlBasicSuggestionsController(ref: ref);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sqlBasicSuggestionsViewModelProvider);

    return SuggestionsSettingsLayoutWidget<String>(
      title: AppLocalizations.of(context)!.basicSuggestions,
      isLoading: state.isLoading,
      initialItems: state.suggestions,
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
