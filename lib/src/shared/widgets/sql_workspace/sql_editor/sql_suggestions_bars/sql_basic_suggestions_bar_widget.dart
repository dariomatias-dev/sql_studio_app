import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

class SqlBasicSuggestionsBarWidget extends StatelessWidget {
  const SqlBasicSuggestionsBarWidget({
    super.key,
    required this.onInsertCommand,
    required this.filterText,
  });

  final void Function(String, {String? selectText}) onInsertCommand;
  final String filterText;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlBasicSuggestionsNotifier>();

    final suggestions = notifier.suggestions.isEmpty
        ? defaultSqlBasicSuggestions
        : notifier.suggestions;

    final filtered = filterText.isEmpty
        ? suggestions
        : suggestions
              .where(
                (suggestion) =>
                    suggestion.toLowerCase().contains(filterText.toLowerCase()),
              )
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
