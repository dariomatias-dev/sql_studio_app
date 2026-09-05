import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

/// Converts a [DatabaseEntity] to and from its persistence map.
class DatabaseMapper {
  const DatabaseMapper._();

  /// Builds a [DatabaseEntity] from a persistence [map].
  static DatabaseEntity fromMap(Map<String, dynamic> map) {
    return DatabaseEntity(
      id: map['id'] as String,
      label: map['label'] as String,
      name: map['name'] as String,
      isFavorite: (map['is_favorite'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// Converts [entity] into a persistence-ready map.
  static Map<String, dynamic> toMap(DatabaseEntity entity) {
    return {
      'id': entity.id,
      'label': entity.label,
      'name': entity.name,
      'is_favorite': entity.isFavorite ? 1 : 0,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
    };
  }
}
