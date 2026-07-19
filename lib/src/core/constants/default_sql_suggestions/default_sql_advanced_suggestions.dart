import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

/// Built-in advanced SQL snippet suggestions shown in the editor.
final defaultSqlAdvancedSuggestions = <SqlAdvancedSuggestionModel>[
  SqlAdvancedSuggestionModel(
    label: 'ALL',
    code: 'SELECT * FROM table_name;',
    selectText: 'table_name',
    orderIndex: 0,
  ),
  SqlAdvancedSuggestionModel(
    label: 'TOP10',
    code: 'SELECT * FROM table_name LIMIT 10;',
    selectText: 'table_name',
    orderIndex: 1,
  ),
  SqlAdvancedSuggestionModel(
    label: 'COUNT',
    code: 'SELECT COUNT(*) FROM table_name;',
    selectText: 'table_name',
    orderIndex: 2,
  ),
  SqlAdvancedSuggestionModel(
    label: 'JOIN',
    code: 'SELECT a.*, b.* FROM table_a a JOIN table_b b ON a.id = b.id;',
    selectText: 'table_a',
    orderIndex: 3,
  ),
  SqlAdvancedSuggestionModel(
    label: 'WHERE',
    code: 'SELECT * FROM table_name WHERE column_name = value;',
    selectText: 'table_name',
    orderIndex: 4,
  ),
  SqlAdvancedSuggestionModel(
    label: 'INS',
    code: 'INSERT INTO table_name (column1, column2) VALUES (value1, value2);',
    selectText: 'table_name',
    orderIndex: 5,
  ),
  SqlAdvancedSuggestionModel(
    label: 'UPD',
    code: 'UPDATE table_name SET column_name = value WHERE id = 1;',
    selectText: 'table_name',
    orderIndex: 6,
  ),
  SqlAdvancedSuggestionModel(
    label: 'DEL',
    code: 'DELETE FROM table_name WHERE id = 1;',
    selectText: 'table_name',
    orderIndex: 7,
  ),
  SqlAdvancedSuggestionModel(
    label: 'DROP',
    code: 'DROP TABLE IF EXISTS table_name;',
    selectText: 'table_name',
    orderIndex: 8,
  ),
  SqlAdvancedSuggestionModel(
    label: 'DESC',
    code: 'DESCRIBE table_name;',
    selectText: 'table_name',
    orderIndex: 9,
  ),
];
