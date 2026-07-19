import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/datasources/workspace_layout_local_datasource.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';

/// [WorkspaceLayoutRepository] backed by [WorkspaceLayoutLocalDatasource].
class WorkspaceLayoutRepositoryImpl implements WorkspaceLayoutRepository {
  /// Creates the repository with its [_datasource] and [_logger].
  const WorkspaceLayoutRepositoryImpl(this._datasource, this._logger);

  final WorkspaceLayoutLocalDatasource _datasource;
  final Logger _logger;

  @override
  WorkspaceLayoutType getSelectedLayout() {
    final savedLayout = _datasource.getLayoutName();

    return savedLayout == WorkspaceLayoutType.tabs.name
        ? WorkspaceLayoutType.tabs
        : WorkspaceLayoutType.split;
  }

  @override
  Future<Result<void>> setLayout(WorkspaceLayoutType layout) async {
    try {
      await _datasource.setLayoutName(layout.name);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Error saving workspace layout',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveWorkspaceLayout),
      );
    }
  }
}
