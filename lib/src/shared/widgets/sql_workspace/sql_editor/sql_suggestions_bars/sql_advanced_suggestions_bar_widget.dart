import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/constants/sql_advanced_suggestions_default.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

class SqlAdvancedSuggestionsBarWidget extends StatelessWidget {
  const SqlAdvancedSuggestionsBarWidget({
    super.key,
    required this.onInsertCommand,
  });

  final void Function(String code, {String? selectText}) onInsertCommand;

  @override
  Widget build(BuildContext context) {
    return SqlSuggestionsBarBaseWidget(
      onTap: (index) {
        final sqlAdvancedSuggestion = sqlAdvancedSuggestionsDefault[index];

        onInsertCommand(
          sqlAdvancedSuggestion.code,
          selectText: sqlAdvancedSuggestion.selectText,
        );
      },
      itemCount: sqlAdvancedSuggestionsDefault.length,
      itemPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      itemBuilder: (index) => sqlAdvancedSuggestionsDefault[index].label,
    );
  }
}
