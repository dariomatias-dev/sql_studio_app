import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';

/// Fetches the full structure of a database.
class GetDatabaseStructureUseCase {
  /// Creates the use case backed by [_getStructure].
  const GetDatabaseStructureUseCase(this._getStructure);

  final GetStructure _getStructure;

  /// Runs the use case for [databaseName].
  Future<List<TableInfoModel>> call(String databaseName) =>
      _getStructure(databaseName);
}
