import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

/// [DatabaseStructureRepository] backed by [SqlExecutionService].
class DatabaseStructureRepositoryImpl implements DatabaseStructureRepository {
  /// Creates the repository with its [_sqlService].
  const DatabaseStructureRepositoryImpl(this._sqlService);

  final SqlExecutionService _sqlService;

  @override
  Future<List<TableInfoModel>> getStructure(String databaseName) {
    return _sqlService.getDatabaseStructure(databaseName: databaseName);
  }
}
