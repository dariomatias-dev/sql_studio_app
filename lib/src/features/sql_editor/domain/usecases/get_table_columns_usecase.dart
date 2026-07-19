import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';

/// Fetches the column names of a table in a named database.
class GetTableColumnsUseCase {
  /// Creates the use case backed by [_repository].
  const GetTableColumnsUseCase(this._repository);

  final SqlCommandsRepository _repository;

  /// Runs the use case for [tableName] in [databaseName].
  Future<List<String>> call({
    required String databaseName,
    required String tableName,
  }) {
    return _repository.getTableColumns(
      databaseName: databaseName,
      tableName: tableName,
    );
  }
}
