import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Inspects the table/column/foreign-key structure of a database.
abstract interface class DatabaseStructureRepository {
  /// Returns the full structure of [databaseName].
  Future<List<TableInfoModel>> getStructure(String databaseName);
}
