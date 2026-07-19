import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

/// Horizontal bar of basic SQL keyword suggestions, filtered by the word
/// currently being typed in the editor.
class SqlBasicSuggestionsBarWidget extends ConsumerWidget {
  /// Creates a basic suggestions bar filtered by [filterText].
  const SqlBasicSuggestionsBarWidget({
    required this.onInsertCommand,
    required this.filterText,
    super.key,
  });

  /// Called with the suggestion value to insert when tapped.
  final void Function(String value, {String? selectText}) onInsertCommand;

  /// Text used to filter the list of suggestions shown.
  final String filterText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sqlBasicSuggestionsViewModelProvider);

    final suggestions = state.suggestions.isEmpty
        ? defaultSqlBasicSuggestions
        : state.suggestions;

    final filtered = filterText.isEmpty || filterText.endsWith(';')
        ? suggestions
        : suggestions
              .where((s) => s.toLowerCase().contains(filterText.toLowerCase()))
              .toList();

    return SqlSuggestionsBarBaseWidget(
      onTap: (index) {
        onInsertCommand(filtered[index]);
      },
      itemCount: filtered.length,
      itemBuilder: (index) => filtered[index],
    );
  }
}
