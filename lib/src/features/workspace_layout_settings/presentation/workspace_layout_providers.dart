import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/view_models/workspace_layout_view_model.dart';

/// Exposes the [WorkspaceLayoutViewModel] and the selected
/// [WorkspaceLayoutType].
final NotifierProvider<WorkspaceLayoutViewModel, WorkspaceLayoutType>
workspaceLayoutViewModelProvider =
    NotifierProvider<WorkspaceLayoutViewModel, WorkspaceLayoutType>(
      WorkspaceLayoutViewModel.new,
    );
