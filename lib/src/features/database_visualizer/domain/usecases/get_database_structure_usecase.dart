import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';

/// Fetches the full structure of a database.
class GetDatabaseStructureUseCase {
  /// Creates the use case backed by [_repository].
  const GetDatabaseStructureUseCase(this._repository);

  final DatabaseStructureRepository _repository;

  /// Runs the use case for [databaseName].
  Future<Result<List<TableInfoEntity>>> call(String databaseName) =>
      _repository.getStructure(databaseName);
}
