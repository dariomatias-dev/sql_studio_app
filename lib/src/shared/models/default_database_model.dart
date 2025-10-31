class DefaultDatabaseModel {
  final String name;
  final String label;
  final String description;
  final List<String> tables;

  const DefaultDatabaseModel({
    required this.name,
    required this.label,
    required this.description,
    required this.tables,
  });
}
