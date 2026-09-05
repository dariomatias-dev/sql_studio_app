import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/providers.dart';

/// Exposes and updates the selected workspace layout.
class WorkspaceLayoutViewModel extends Notifier<WorkspaceLayoutType> {
  late final WorkspaceLayoutRepository _repository;

  @override
  WorkspaceLayoutType build() {
    _repository = ref.read(workspaceLayoutRepositoryProvider);

    return _repository.getSelectedLayout();
  }

  /// Selects [layout] as the active workspace layout and persists it.
  Future<Result<void>> setLayout(WorkspaceLayoutType layout) async {
    final result = await _repository.setLayout(layout);

    if (result.isSuccess) state = layout;

    return result;
  }
}
