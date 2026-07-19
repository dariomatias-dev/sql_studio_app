import 'package:uuid/uuid.dart';

/// A saved user database record.
class DatabaseModel {
  /// Creates a database record, generating an [id] and timestamps
  /// when not provided.
  DatabaseModel({
    required this.label,
    required this.name,
    String? id,
    this.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

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

  /// Unique identifier of the database.
  final String id;

  /// Display label shown to the user.
  final String label;

  /// Underlying database file name.
  final String name;

  /// Whether the database is marked as a favorite.
  final bool isFavorite;

  /// When the database was created.
  final DateTime createdAt;

  /// When the database was last updated.
  final DateTime updatedAt;

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
