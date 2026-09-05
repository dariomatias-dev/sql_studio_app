import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/mappers/sql_advanced_suggestion_mapper.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';

void main() {
  group('toMap / fromMap', () {
    test('round-trips every field through a persistence map', () {
      final original = SqlAdvancedSuggestionEntity(
        label: 'Select all',
        code: 'SELECT * FROM table_name;',
        orderIndex: 2,
        selectText: 'table_name',
      );

      final restored = SqlAdvancedSuggestionMapper.fromMap(
        SqlAdvancedSuggestionMapper.toMap(original),
      );

      expect(restored.id, original.id);
      expect(restored.label, original.label);
      expect(restored.code, original.code);
      expect(restored.selectText, original.selectText);
      expect(restored.orderIndex, original.orderIndex);
    });

    test('round-trips a null selectText', () {
      final original = SqlAdvancedSuggestionEntity(
        label: 'Select all',
        code: 'SELECT * FROM table_name;',
        orderIndex: 0,
      );

      final restored = SqlAdvancedSuggestionMapper.fromMap(
        SqlAdvancedSuggestionMapper.toMap(original),
      );

      expect(restored.selectText, isNull);
    });
  });
}
