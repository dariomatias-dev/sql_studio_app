import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';

void main() {
  group('toMap / fromMap', () {
    test('round-trips every field through a persistence map', () {
      final original = DatabaseModel(
        label: 'Todo List',
        name: 'todo_list',
        isFavorite: true,
      );

      final restored = DatabaseModel.fromMap(original.toMap());

      expect(restored.id, original.id);
      expect(restored.label, original.label);
      expect(restored.name, original.name);
      expect(restored.isFavorite, original.isFavorite);
      expect(restored.createdAt, original.createdAt);
      expect(restored.updatedAt, original.updatedAt);
    });

    test('encodes isFavorite as 1/0 and decodes it back to a bool', () {
      final favorite = DatabaseModel(
        label: 'A',
        name: 'a',
        isFavorite: true,
      );
      final other = DatabaseModel(label: 'B', name: 'b');

      expect(favorite.toMap()['is_favorite'], 1);
      expect(other.toMap()['is_favorite'], 0);
      expect(DatabaseModel.fromMap(favorite.toMap()).isFavorite, isTrue);
      expect(DatabaseModel.fromMap(other.toMap()).isFavorite, isFalse);
    });
  });

  group('copyWith', () {
    test('replaces only the given fields', () {
      final original = DatabaseModel(label: 'A', name: 'a');

      final updated = original.copyWith(label: 'B');

      expect(updated.label, 'B');
      expect(updated.name, original.name);
      expect(updated.id, original.id);
    });

    test('keeps every field when called with no arguments', () {
      final original = DatabaseModel(label: 'A', name: 'a');

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
    final a = DatabaseModel(label: 'A', name: 'a');
    final b = DatabaseModel(label: 'A', name: 'a');

    expect(a.id, isNot(b.id));
  });
}
