import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Presentation state for the database visualizer.
class DatabaseVisualizerState {
  /// Creates the state. [tables] is `null` while loading for the first
  /// time, and an empty list when the database has no tables.
  const DatabaseVisualizerState({this.tables});

  /// The visualized database's tables, or `null` before the first load.
  final List<TableInfoModel>? tables;
}
