import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/services/database/default_database_service.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

/// [SqlCommandsRepository] backed by [SqlExecutionService] and
/// [DefaultDatabaseService].
class SqlCommandsRepositoryImpl implements SqlCommandsRepository {
  /// Creates the repository with its [_sqlService].
  const SqlCommandsRepositoryImpl(this._sqlService);

  final SqlExecutionService _sqlService;

  @override
  Future<Result<DatabaseSuccess?>> execute({
    required String sql,
    required String databaseName,
  }) {
    return _sqlService.execute(sql: sql, databaseName: databaseName);
  }

  @override
  Future<List<String>> getTableColumns({
    required String databaseName,
    required String tableName,
  }) {
    return _sqlService.getTableColumns(
      databaseName: databaseName,
      tableName: tableName,
    );
  }

  @override
  Future<Result<void>> resetDefaultDatabase(String databaseName) {
    return DefaultDatabaseService.execute(databaseName);
  }
}
