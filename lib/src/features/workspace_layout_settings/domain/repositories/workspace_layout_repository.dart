import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

/// Persists and retrieves the user's chosen workspace layout.
abstract interface class WorkspaceLayoutRepository {
  /// Reads the previously persisted layout, defaulting to
  /// [WorkspaceLayoutType.split] when none was saved.
  WorkspaceLayoutType getSelectedLayout();

  /// Persists [layout] as the active workspace layout.
  Future<Result<void>> setLayout(WorkspaceLayoutType layout);
}
