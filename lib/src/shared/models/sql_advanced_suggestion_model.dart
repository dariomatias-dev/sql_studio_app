import 'package:uuid/uuid.dart';

/// A saved advanced SQL suggestion shown in the query editor.
class SqlAdvancedSuggestionModel {
  /// Creates a suggestion, generating an [id] when not provided.
  SqlAdvancedSuggestionModel({
    required this.label,
    required this.code,
    required this.orderIndex,
    String? id,
    this.selectText,
  }) : id = id ?? const Uuid().v4();

  /// Builds a [SqlAdvancedSuggestionModel] from a persistence [map].
  factory SqlAdvancedSuggestionModel.fromMap(Map<String, dynamic> map) {
    return SqlAdvancedSuggestionModel(
      id: map['id'] as String,
      label: map['label'] as String,
      code: map['code'] as String,
      selectText: map['select_text'] as String?,
      orderIndex: map['order_index'] as int,
    );
  }

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

  /// Returns a copy of this model with the given fields replaced.
  SqlAdvancedSuggestionModel copyWith({
    String? id,
    String? label,
    String? code,
    String? selectText,
    int? orderIndex,
  }) {
    return SqlAdvancedSuggestionModel(
      id: id ?? this.id,
      label: label ?? this.label,
      code: code ?? this.code,
      selectText: selectText ?? this.selectText,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  /// Converts this model into a persistence-ready map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'code': code,
      'select_text': selectText,
      'order_index': orderIndex,
    };
  }
}
