import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/database_visualizer/domain/usecases/get_database_structure_usecase.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_state.dart';

/// Loads and exposes a database's table/column/foreign-key structure.
class DatabaseVisualizerViewModel extends Notifier<DatabaseVisualizerState> {
  late final GetDatabaseStructureUseCase _getStructure;

  @override
  DatabaseVisualizerState build() {
    _getStructure = ref.read(getDatabaseStructureUseCaseProvider);

    return const DatabaseVisualizerState();
  }

  /// Loads the structure of [databaseName].
  Future<void> load(String databaseName) async {
    final tables = await _getStructure(databaseName);

    state = DatabaseVisualizerState(tables: tables);
  }
}
