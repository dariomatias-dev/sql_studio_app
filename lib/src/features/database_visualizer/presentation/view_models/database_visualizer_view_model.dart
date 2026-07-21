import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_state.dart';

/// Loads and exposes a database's table/column/foreign-key structure.
class DatabaseVisualizerViewModel extends Notifier<DatabaseVisualizerState> {
  @override
  DatabaseVisualizerState build() => const DatabaseVisualizerState();

  /// Loads the structure of [databaseName].
  Future<void> load(String databaseName) async {
    final getStructure = ref.read(getDatabaseStructureUseCaseProvider);
    final tables = await getStructure(databaseName);

    state = DatabaseVisualizerState(tables: tables);
  }
}
