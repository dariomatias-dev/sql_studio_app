import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

class SqlAdvancedSuggestionsBarWidget extends StatelessWidget {
  const SqlAdvancedSuggestionsBarWidget({
    super.key,
    required this.onInsertCommand,
  });

  final void Function(String code, {String? selectText}) onInsertCommand;

  @override
  Widget build(BuildContext context) {
    final suggestions = context.watch<SqlAdvancedSuggestionsNotifier>().advancedSuggestions;

    return SqlSuggestionsBarBaseWidget(
      onTap: (index) {
        final sqlAdvancedSuggestion = suggestions[index];

        onInsertCommand(
          sqlAdvancedSuggestion.code,
          selectText: sqlAdvancedSuggestion.selectText,
        );
      },
      itemCount: suggestions.length,
      itemPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      itemBuilder: (index) => suggestions[index].label,
    );
  }
}
