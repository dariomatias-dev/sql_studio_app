import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart'
    as domain;

/// [domain.DatabaseStructureRepository] backed by [SqlExecutionService].
class DatabaseStructureRepositoryImpl
    implements domain.DatabaseStructureRepository {
  /// Creates the repository with its [_sqlService] and [_logger].
  const DatabaseStructureRepositoryImpl(this._sqlService, this._logger);

  final SqlExecutionService _sqlService;
  final AppLogger _logger;

  @override
  Future<Result<List<TableInfoEntity>>> getStructure(
    String databaseName,
  ) async {
    try {
      final tables = await _sqlService.getDatabaseStructure(
        databaseName: databaseName,
      );

      return SuccessResult(tables);
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to fetch database structure',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.failedToLoadDatabaseStructure),
      );
    }
  }
}
