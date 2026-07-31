import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';

/// [SqlCommandsRepository] backed by [SqlExecutionService] and
/// [DefaultDatabaseService].
class SqlCommandsRepositoryImpl implements SqlCommandsRepository {
  /// Creates the repository with its [_sqlService] and
  /// [_defaultDatabaseService].
  const SqlCommandsRepositoryImpl(
    this._sqlService,
    this._defaultDatabaseService,
  );

  final SqlExecutionService _sqlService;
  final DefaultDatabaseService _defaultDatabaseService;

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
    return _defaultDatabaseService.execute(databaseName);
  }
}
