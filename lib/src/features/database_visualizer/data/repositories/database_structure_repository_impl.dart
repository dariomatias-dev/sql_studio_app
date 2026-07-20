import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Inspects the table/column/foreign-key structure of a database, backed
/// by [SqlExecutionService].
class DatabaseStructureRepositoryImpl {
  /// Creates the repository with its [_sqlService].
  const DatabaseStructureRepositoryImpl(this._sqlService);

  final SqlExecutionService _sqlService;

  /// Returns the full structure of [databaseName].
  Future<List<TableInfoModel>> getStructure(String databaseName) {
    return _sqlService.getDatabaseStructure(databaseName: databaseName);
  }
}
