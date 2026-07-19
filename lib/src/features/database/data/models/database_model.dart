import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:uuid/uuid.dart';

/// A saved user database record.
class DatabaseModel extends DatabaseEntity {
  /// Creates a database record, generating an [id] and timestamps
  /// when not provided.
  DatabaseModel({
    required super.label,
    required super.name,
    String? id,
    super.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
         id: id ?? const Uuid().v4(),
         createdAt: createdAt ?? DateTime.now(),
         updatedAt: updatedAt ?? DateTime.now(),
       );

  /// Builds a [DatabaseModel] from a persistence [map].
  factory DatabaseModel.fromMap(Map<String, dynamic> map) {
    return DatabaseModel(
      id: map['id'] as String,
      label: map['label'] as String,
      name: map['name'] as String,
      isFavorite: (map['is_favorite'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// Converts this model into a persistence-ready map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'name': name,
      'is_favorite': isFavorite ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Returns a copy of this model with the given fields replaced.
  DatabaseModel copyWith({
    String? id,
    String? label,
    String? name,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DatabaseModel(
      id: id ?? this.id,
      label: label ?? this.label,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
