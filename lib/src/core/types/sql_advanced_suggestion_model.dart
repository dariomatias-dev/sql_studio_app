class SqlAdvancedSuggestionModel {
  final String label;
  final String code;
  final String? selectText;

  const SqlAdvancedSuggestionModel({
    required this.label,
    required this.code,
    this.selectText,
  });
}
