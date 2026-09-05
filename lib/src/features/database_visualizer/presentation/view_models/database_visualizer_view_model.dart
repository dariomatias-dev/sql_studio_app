import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/view_models/database_visualizer_state.dart';

/// Loads and exposes a database's table/column/foreign-key structure.
class DatabaseVisualizerViewModel extends Notifier<DatabaseVisualizerState> {
  @override
  DatabaseVisualizerState build() => const DatabaseVisualizerState();

  /// Loads the structure of [databaseName].
  Future<Result<void>> load(String databaseName) async {
    final getStructure = ref.read(getDatabaseStructureUseCaseProvider);
    final result = await getStructure(databaseName);

    return result.when(
      onSuccess: (tables) {
        state = DatabaseVisualizerState(tables: tables);

        return const SuccessResult(null);
      },
      onFailure: (error) {
        state = const DatabaseVisualizerState(tables: []);

        return FailureResult(error);
      },
    );
  }
}
