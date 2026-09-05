import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

void main() {
  group('copyWith', () {
    test('replaces only the given fields', () {
      final original = DatabaseEntity(label: 'A', name: 'a');

      final updated = original.copyWith(label: 'B');

      expect(updated.label, 'B');
      expect(updated.name, original.name);
      expect(updated.id, original.id);
    });

    test('keeps every field when called with no arguments', () {
      final original = DatabaseEntity(label: 'A', name: 'a');

      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.label, original.label);
      expect(copy.name, original.name);
      expect(copy.isFavorite, original.isFavorite);
      expect(copy.createdAt, original.createdAt);
      expect(copy.updatedAt, original.updatedAt);
    });
  });

  test('generates a unique id when none is provided', () {
    final a = DatabaseEntity(label: 'A', name: 'a');
    final b = DatabaseEntity(label: 'A', name: 'a');

    expect(a.id, isNot(b.id));
  });
}
