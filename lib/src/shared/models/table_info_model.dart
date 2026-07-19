/// Describes a single column of a database table.
class ColumnInfoModel {
  /// Creates a column description.
  ColumnInfoModel({
    required this.name,
    required this.type,
    this.foreignTable,
    this.foreignColumn,
  });

  /// Column name.
  final String name;

  /// Declared SQL type of the column.
  final String type;

  /// Name of the foreign table this column references, if any.
  final String? foreignTable;

  /// Name of the foreign column this column references, if any.
  final String? foreignColumn;
}

/// Describes a database table and its columns.
class TableInfoModel {
  /// Creates a table description.
  TableInfoModel({required this.name, required this.columns});

  /// Table name.
  final String name;

  /// Columns belonging to this table.
  final List<ColumnInfoModel> columns;
}
