class ColumnInfo {
  final String name;
  final String type;
  final String? foreignTable;
  final String? foreignColumn;

  ColumnInfo({
    required this.name,
    required this.type,
    this.foreignTable,
    this.foreignColumn,
  });
}

class TableInfo {
  final String name;
  final List<ColumnInfo> columns;

  TableInfo({required this.name, required this.columns});
}
