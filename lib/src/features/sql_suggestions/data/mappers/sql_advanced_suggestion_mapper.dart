import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';

/// Converts a [SqlAdvancedSuggestionEntity] to and from its persistence
/// map.
class SqlAdvancedSuggestionMapper {
  const SqlAdvancedSuggestionMapper._();

  /// Builds a [SqlAdvancedSuggestionEntity] from a persistence [map].
  static SqlAdvancedSuggestionEntity fromMap(Map<String, dynamic> map) {
    return SqlAdvancedSuggestionEntity(
      id: map['id'] as String,
      label: map['label'] as String,
      code: map['code'] as String,
      selectText: map['select_text'] as String?,
      orderIndex: map['order_index'] as int,
    );
  }

  /// Converts [entity] into a persistence-ready map.
  static Map<String, dynamic> toMap(SqlAdvancedSuggestionEntity entity) {
    return {
      'id': entity.id,
      'label': entity.label,
      'code': entity.code,
      'select_text': entity.selectText,
      'order_index': entity.orderIndex,
    };
  }
}
