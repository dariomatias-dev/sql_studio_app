class DefaultDatabaseModel {
  final String name;
  final String labelKey;
  final String descriptionKey;
  final List<String> tables;

  const DefaultDatabaseModel({
    required this.name,
    required this.labelKey,
    required this.descriptionKey,
    required this.tables,
  });
}
