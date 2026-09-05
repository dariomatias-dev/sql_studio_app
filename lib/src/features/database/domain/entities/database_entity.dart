import 'package:uuid/uuid.dart';

/// A saved user database.
class DatabaseEntity {
  /// Creates a database, generating an [id] and timestamps when not
  /// provided.
  DatabaseEntity({
    required this.label,
    required this.name,
    String? id,
    this.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

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

  /// Returns a copy of this database with the given fields replaced.
  DatabaseEntity copyWith({
    String? id,
    String? label,
    String? name,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DatabaseEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
