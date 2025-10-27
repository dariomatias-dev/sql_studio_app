class DatabaseModel {
  final String label;
  final String name;
  bool isFavorite;

  DatabaseModel({
    required this.label,
    required this.name,
    this.isFavorite = false,
  });
}
