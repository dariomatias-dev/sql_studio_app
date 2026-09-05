import 'package:uuid/uuid.dart';

/// A saved advanced SQL suggestion shown in the query editor.
class SqlAdvancedSuggestionEntity {
  /// Creates a suggestion, generating an [id] when not provided.
  SqlAdvancedSuggestionEntity({
    required this.label,
    required this.code,
    required this.orderIndex,
    String? id,
    this.selectText,
  }) : id = id ?? const Uuid().v4();

  /// Unique identifier of the suggestion.
  final String id;

  /// Display label shown to the user.
  final String label;

  /// SQL code snippet inserted when the suggestion is applied.
  final String code;

  /// Optional text to pre-select once [code] is inserted.
  final String? selectText;

  /// Position of this suggestion relative to the others.
  final int orderIndex;

  /// Returns a copy of this suggestion with the given fields replaced.
  SqlAdvancedSuggestionEntity copyWith({
    String? id,
    String? label,
    String? code,
    String? selectText,
    int? orderIndex,
  }) {
    return SqlAdvancedSuggestionEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      code: code ?? this.code,
      selectText: selectText ?? this.selectText,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
