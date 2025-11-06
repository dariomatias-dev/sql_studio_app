import 'package:uuid/uuid.dart';

class SqlAdvancedSuggestionModel {
  final String id;
  final String label;
  final String code;
  final String? selectText;

  SqlAdvancedSuggestionModel({
    String? id,
    required this.label,
    required this.code,
    this.selectText,
  }) : id = id ?? const Uuid().v4();

  SqlAdvancedSuggestionModel copyWith({
    String? id,
    String? label,
    String? code,
    String? selectText,
  }) {
    return SqlAdvancedSuggestionModel(
      id: id ?? this.id,
      label: label ?? this.label,
      code: code ?? this.code,
      selectText: selectText ?? this.selectText,
    );
  }

  static SqlAdvancedSuggestionModel fromMap(Map<String, dynamic> map) {
    return SqlAdvancedSuggestionModel(
      id: map['id'] as String,
      label: map['label'] as String,
      code: map['code'] as String,
      selectText: map['select_text'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'code': code, 'select_text': selectText};
  }
}
