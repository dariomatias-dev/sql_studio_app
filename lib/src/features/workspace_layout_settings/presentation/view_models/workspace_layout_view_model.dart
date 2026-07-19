import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/get_selected_workspace_layout_usecase.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/set_workspace_layout_usecase.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/providers.dart';

/// Exposes and updates the selected workspace layout.
class WorkspaceLayoutViewModel extends Notifier<WorkspaceLayoutType> {
  late final GetSelectedWorkspaceLayoutUseCase _getSelectedLayout;
  late final SetWorkspaceLayoutUseCase _setLayout;

  @override
  WorkspaceLayoutType build() {
    _getSelectedLayout = ref.read(getSelectedWorkspaceLayoutUseCaseProvider);
    _setLayout = ref.read(setWorkspaceLayoutUseCaseProvider);

    return _getSelectedLayout();
  }

  /// Selects [layout] as the active workspace layout and persists it.
  Future<Result<void>> setLayout(WorkspaceLayoutType layout) async {
    final result = await _setLayout(layout);

    if (result is SuccessResult<void>) state = layout;

    return result;
  }
}
