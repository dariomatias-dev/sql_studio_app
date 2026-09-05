import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';

void main() {
  group('copyWith', () {
    test('replaces only the given fields', () {
      final original = SqlAdvancedSuggestionEntity(
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
    final a = SqlAdvancedSuggestionEntity(
      label: 'A',
      code: 'SELECT 1',
      orderIndex: 0,
    );
    final b = SqlAdvancedSuggestionEntity(
      label: 'A',
      code: 'SELECT 1',
      orderIndex: 0,
    );

    expect(a.id, isNot(b.id));
  });
}
