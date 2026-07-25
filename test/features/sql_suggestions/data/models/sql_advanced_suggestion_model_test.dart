import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';

void main() {
  group('toMap / fromMap', () {
    test('round-trips every field through a persistence map', () {
      final original = SqlAdvancedSuggestionModel(
        label: 'Select all',
        code: 'SELECT * FROM table_name;',
        orderIndex: 2,
        selectText: 'table_name',
      );

      final restored = SqlAdvancedSuggestionModel.fromMap(original.toMap());

      expect(restored.id, original.id);
      expect(restored.label, original.label);
      expect(restored.code, original.code);
      expect(restored.selectText, original.selectText);
      expect(restored.orderIndex, original.orderIndex);
    });

    test('round-trips a null selectText', () {
      final original = SqlAdvancedSuggestionModel(
        label: 'Select all',
        code: 'SELECT * FROM table_name;',
        orderIndex: 0,
      );

      final restored = SqlAdvancedSuggestionModel.fromMap(original.toMap());

      expect(restored.selectText, isNull);
    });
  });

  group('copyWith', () {
    test('replaces only the given fields', () {
      final original = SqlAdvancedSuggestionModel(
        label: 'A',
        code: 'SELECT 1',
        orderIndex: 0,
      );

      final updated = original.copyWith(orderIndex: 5);

      expect(updated.orderIndex, 5);
      expect(updated.label, original.label);
      expect(updated.code, original.code);
      expect(updated.id, original.id);
    });
  });

  test('generates a unique id when none is provided', () {
    final a = SqlAdvancedSuggestionModel(
      label: 'A',
      code: 'SELECT 1',
      orderIndex: 0,
    );
    final b = SqlAdvancedSuggestionModel(
      label: 'A',
      code: 'SELECT 1',
      orderIndex: 0,
    );

    expect(a.id, isNot(b.id));
  });
}
