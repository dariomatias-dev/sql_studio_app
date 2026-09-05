import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';

/// Built-in advanced SQL snippet suggestions shown in the editor.
final defaultSqlAdvancedSuggestions = <SqlAdvancedSuggestionEntity>[
  SqlAdvancedSuggestionEntity(
    label: 'ALL',
    code: 'SELECT * FROM table_name;',
    selectText: 'table_name',
    orderIndex: 0,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'TOP10',
    code: 'SELECT * FROM table_name LIMIT 10;',
    selectText: 'table_name',
    orderIndex: 1,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'COUNT',
    code: 'SELECT COUNT(*) FROM table_name;',
    selectText: 'table_name',
    orderIndex: 2,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'JOIN',
    code: 'SELECT a.*, b.* FROM table_a a JOIN table_b b ON a.id = b.id;',
    selectText: 'table_a',
    orderIndex: 3,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'WHERE',
    code: 'SELECT * FROM table_name WHERE column_name = value;',
    selectText: 'table_name',
    orderIndex: 4,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'INS',
    code: 'INSERT INTO table_name (column1, column2) VALUES (value1, value2);',
    selectText: 'table_name',
    orderIndex: 5,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'UPD',
    code: 'UPDATE table_name SET column_name = value WHERE id = 1;',
    selectText: 'table_name',
    orderIndex: 6,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'DEL',
    code: 'DELETE FROM table_name WHERE id = 1;',
    selectText: 'table_name',
    orderIndex: 7,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'DROP',
    code: 'DROP TABLE IF EXISTS table_name;',
    selectText: 'table_name',
    orderIndex: 8,
  ),
  SqlAdvancedSuggestionEntity(
    label: 'DESC',
    code: 'DESCRIBE table_name;',
    selectText: 'table_name',
    orderIndex: 9,
  ),
];
