import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

/// Horizontal bar of user-defined advanced SQL suggestions that insert a
/// snippet of code, optionally selecting part of it, when tapped.
class SqlAdvancedSuggestionsBarWidget extends ConsumerWidget {
  /// Creates an advanced suggestions bar.
  const SqlAdvancedSuggestionsBarWidget({
    required this.onInsertCommand,
    super.key,
  });

  /// Called with the code snippet to insert, and the text to select
  /// afterwards, when a suggestion is tapped.
  final void Function(String code, {String? selectText}) onInsertCommand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestions = ref
        .watch(sqlAdvancedSuggestionsViewModelProvider)
        .suggestions;

    return SqlSuggestionsBarBaseWidget(
      onTap: (index) {
        final sqlAdvancedSuggestion = suggestions[index];

        onInsertCommand(
          sqlAdvancedSuggestion.code,
          selectText: sqlAdvancedSuggestion.selectText,
        );
      },
      itemCount: suggestions.length,
      itemPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      itemBuilder: (index) => suggestions[index].label,
    );
  }
}
