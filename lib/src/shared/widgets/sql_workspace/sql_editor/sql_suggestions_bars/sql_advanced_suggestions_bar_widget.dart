import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

class SqlQuickSuggestion {
  final String label;
  final String code;
  final String? selectText;

  const SqlQuickSuggestion({
    required this.label,
    required this.code,
    this.selectText,
  });
}

final quickSuggestions = <SqlQuickSuggestion>[
  SqlQuickSuggestion(
    label: 'ALL',
    code: 'SELECT * FROM table_name;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'TOP10',
    code: 'SELECT * FROM table_name LIMIT 10;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'COUNT',
    code: 'SELECT COUNT(*) FROM table_name;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'JOIN',
    code: 'SELECT a.*, b.* FROM table_a a JOIN table_b b ON a.id = b.id;',
    selectText: 'table_a',
  ),
  SqlQuickSuggestion(
    label: 'WHERE',
    code: 'SELECT * FROM table_name WHERE column_name = value;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'INS',
    code: 'INSERT INTO table_name (column1, column2) VALUES (value1, value2);',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'UPD',
    code: 'UPDATE table_name SET column_name = value WHERE id = 1;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'DEL',
    code: 'DELETE FROM table_name WHERE id = 1;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'DROP',
    code: 'DROP TABLE IF EXISTS table_name;',
    selectText: 'table_name',
  ),
  SqlQuickSuggestion(
    label: 'DESC',
    code: 'DESCRIBE table_name;',
    selectText: 'table_name',
  ),
];

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
        final quickSuggestion = quickSuggestions[index];

        onInsertCommand(
          quickSuggestion.code,
          selectText: quickSuggestion.selectText,
        );
      },
      itemCount: quickSuggestions.length,
      itemPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      itemBuilder: (index) => quickSuggestions[index].label,
    );
  }
}
