import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/datasources/workspace_layout_local_datasource.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/repositories/workspace_layout_repository_impl.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';

/// Provides the raw workspace layout preference datasource.
final Provider<WorkspaceLayoutLocalDatasource>
workspaceLayoutLocalDatasourceProvider = Provider(
  (ref) => WorkspaceLayoutLocalDatasource(
    ref.watch(sharedPreferencesServiceProvider),
  ),
);

/// Provides the [WorkspaceLayoutRepository] implementation.
final Provider<WorkspaceLayoutRepository> workspaceLayoutRepositoryProvider =
    Provider(
      (ref) => WorkspaceLayoutRepositoryImpl(
        ref.watch(workspaceLayoutLocalDatasourceProvider),
        ref.watch(appLoggerProvider),
      ),
    );
