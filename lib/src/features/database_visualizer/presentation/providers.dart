import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/database_visualizer/data/repositories/database_structure_repository_impl.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/usecases/get_database_structure_usecase.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_state.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_view_model.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart'
    show sqlExecutionServiceProvider;

/// Provides the [DatabaseStructureRepositoryImpl].
final Provider<DatabaseStructureRepositoryImpl>
databaseStructureRepositoryProvider = Provider(
  (ref) =>
      DatabaseStructureRepositoryImpl(ref.watch(sqlExecutionServiceProvider)),
);

/// Provides the [GetDatabaseStructureUseCase].
final Provider<GetDatabaseStructureUseCase>
getDatabaseStructureUseCaseProvider = Provider(
  (ref) => GetDatabaseStructureUseCase(
    ref.watch(databaseStructureRepositoryProvider).getStructure,
  ),
);

/// Exposes the [DatabaseVisualizerViewModel] and its
/// [DatabaseVisualizerState].
final NotifierProvider<DatabaseVisualizerViewModel, DatabaseVisualizerState>
databaseVisualizerViewModelProvider = NotifierProvider(
  DatabaseVisualizerViewModel.new,
);
