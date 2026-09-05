import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database/data/mappers/database_mapper.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

void main() {
  group('toMap / fromMap', () {
    test('round-trips every field through a persistence map', () {
      final original = DatabaseEntity(
        label: 'Todo List',
        name: 'todo_list',
        isFavorite: true,
      );

      final restored = DatabaseMapper.fromMap(DatabaseMapper.toMap(original));

      expect(restored.id, original.id);
      expect(restored.label, original.label);
      expect(restored.name, original.name);
      expect(restored.isFavorite, original.isFavorite);
      expect(restored.createdAt, original.createdAt);
      expect(restored.updatedAt, original.updatedAt);
    });

    test('encodes isFavorite as 1/0 and decodes it back to a bool', () {
      final favorite = DatabaseEntity(
        label: 'A',
        name: 'a',
        isFavorite: true,
      );
      final other = DatabaseEntity(label: 'B', name: 'b');

      expect(DatabaseMapper.toMap(favorite)['is_favorite'], 1);
      expect(DatabaseMapper.toMap(other)['is_favorite'], 0);
      expect(
        DatabaseMapper.fromMap(DatabaseMapper.toMap(favorite)).isFavorite,
        isTrue,
      );
      expect(
        DatabaseMapper.fromMap(DatabaseMapper.toMap(other)).isFavorite,
        isFalse,
      );
    });
  });
}
