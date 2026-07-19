import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';

/// Persists the selected workspace layout.
class SetWorkspaceLayoutUseCase {
  /// Creates the use case backed by [_repository].
  const SetWorkspaceLayoutUseCase(this._repository);

  final WorkspaceLayoutRepository _repository;

  /// Runs the use case.
  Future<Result<void>> call(WorkspaceLayoutType layout) =>
      _repository.setLayout(layout);
}
