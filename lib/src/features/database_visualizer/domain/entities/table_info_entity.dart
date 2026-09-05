/// Describes a single column of a database table.
class ColumnInfoEntity {
  /// Creates a column description.
  ColumnInfoEntity({
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
class TableInfoEntity {
  /// Creates a table description.
  TableInfoEntity({required this.name, required this.columns});

  /// Table name.
  final String name;

  /// Columns belonging to this table.
  final List<ColumnInfoEntity> columns;
}
