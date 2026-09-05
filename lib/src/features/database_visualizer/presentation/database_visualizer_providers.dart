import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_state.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_view_model.dart';

/// Exposes the [DatabaseVisualizerViewModel] and its
/// [DatabaseVisualizerState].
///
/// Auto-disposes once the visualizer screen is popped, so each visit
/// starts from a clean state without needing a manual `ref.invalidate`.
final NotifierProvider<DatabaseVisualizerViewModel, DatabaseVisualizerState>
databaseVisualizerViewModelProvider = NotifierProvider(
  DatabaseVisualizerViewModel.new,
  isAutoDispose: true,
);
