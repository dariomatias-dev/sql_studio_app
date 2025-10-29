import 'package:uuid/uuid.dart';

class DatabaseModel {
  final String id;
  final String label;
  final String name;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;

  DatabaseModel({
    String? id,
    required this.label,
    required this.name,
    this.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DatabaseModel.fromMap(Map<String, dynamic> map) {
    return DatabaseModel(
      id: map['id'] as String,
      label: map['label'] as String,
      name: map['name'] as String,
      isFavorite: (map['is_favorite'] as int) == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

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
