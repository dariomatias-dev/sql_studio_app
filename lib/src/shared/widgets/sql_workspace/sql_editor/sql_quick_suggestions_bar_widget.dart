import 'package:flutter/material.dart';

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

class SqlQuickSuggestionsBarWidget extends StatelessWidget {
  const SqlQuickSuggestionsBarWidget({
    super.key,
    required this.onInsertCommand,
  });

  final void Function(String code, {String? selectText}) onInsertCommand;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      height: 48.0,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: quickSuggestions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 4.0),
        itemBuilder: (context, index) {
          final quickSuggestion = quickSuggestions[index];

          return InkWell(
            borderRadius: BorderRadius.circular(6.0),
            onTap: () => onInsertCommand(
              quickSuggestion.code,
              selectText: quickSuggestion.selectText,
            ),
            child: Container(
              width: 56.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 2.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Text(
                quickSuggestion.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                  height: 1.1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
