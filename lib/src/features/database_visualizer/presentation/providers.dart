import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/database_visualizer/data/repositories/database_structure_repository_impl.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_state.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_view_model.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart'
    show sqlExecutionServiceProvider;

/// Provides the [DatabaseStructureRepository] implementation.
final Provider<DatabaseStructureRepository>
databaseStructureRepositoryProvider = Provider(
  (ref) => DatabaseStructureRepositoryImpl(
    ref.watch(sqlExecutionServiceProvider),
    ref.watch(appLoggerProvider),
  ),
);

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
