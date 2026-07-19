import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';

/// Reads the persisted workspace layout.
class GetSelectedWorkspaceLayoutUseCase {
  /// Creates the use case backed by [_repository].
  const GetSelectedWorkspaceLayoutUseCase(this._repository);

  final WorkspaceLayoutRepository _repository;

  /// Runs the use case.
  WorkspaceLayoutType call() => _repository.getSelectedLayout();
}
