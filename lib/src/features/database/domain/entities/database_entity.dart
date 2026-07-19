/// A saved user database.
abstract class DatabaseEntity {
  /// Creates a database entity from its persisted fields.
  const DatabaseEntity({
    required this.id,
    required this.label,
    required this.name,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });

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
}
