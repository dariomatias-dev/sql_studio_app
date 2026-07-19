import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/datasources/workspace_layout_local_datasource.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/repositories/workspace_layout_repository_impl.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/get_selected_workspace_layout_usecase.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/set_workspace_layout_usecase.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/view_models/workspace_layout_view_model.dart';

/// Provides the raw workspace layout preference datasource.
final Provider<WorkspaceLayoutLocalDatasource>
workspaceLayoutLocalDatasourceProvider = Provider(
  (ref) => const WorkspaceLayoutLocalDatasource(),
);

/// Provides the [WorkspaceLayoutRepository] implementation.
final Provider<WorkspaceLayoutRepository> workspaceLayoutRepositoryProvider =
    Provider(
      (ref) => WorkspaceLayoutRepositoryImpl(
        ref.watch(workspaceLayoutLocalDatasourceProvider),
        ref.watch(loggerProvider),
      ),
    );

/// Provides the [GetSelectedWorkspaceLayoutUseCase].
final Provider<GetSelectedWorkspaceLayoutUseCase>
getSelectedWorkspaceLayoutUseCaseProvider = Provider(
  (ref) => GetSelectedWorkspaceLayoutUseCase(
    ref.watch(workspaceLayoutRepositoryProvider),
  ),
);

/// Provides the [SetWorkspaceLayoutUseCase].
final Provider<SetWorkspaceLayoutUseCase> setWorkspaceLayoutUseCaseProvider =
    Provider(
      (ref) => SetWorkspaceLayoutUseCase(
        ref.watch(workspaceLayoutRepositoryProvider),
      ),
    );

/// Exposes the [WorkspaceLayoutViewModel] and the selected
/// [WorkspaceLayoutType].
final NotifierProvider<WorkspaceLayoutViewModel, WorkspaceLayoutType>
workspaceLayoutViewModelProvider =
    NotifierProvider<WorkspaceLayoutViewModel, WorkspaceLayoutType>(
      WorkspaceLayoutViewModel.new,
    );
