class ColumnInfoModel {
  final String name;
  final String type;
  final String? foreignTable;
  final String? foreignColumn;

  ColumnInfoModel({
    required this.name,
    required this.type,
    this.foreignTable,
    this.foreignColumn,
  });
}

class TableInfoModel {
  final String name;
  final List<ColumnInfoModel> columns;

  TableInfoModel({required this.name, required this.columns});
}
