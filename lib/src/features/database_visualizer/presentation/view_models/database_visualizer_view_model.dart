import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
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

    if (result is SuccessResult<List<TableInfoModel>>) {
      state = DatabaseVisualizerState(tables: result.value);

      return const SuccessResult(null);
    } else if (result is FailureResult<List<TableInfoModel>>) {
      state = const DatabaseVisualizerState(tables: []);

      return FailureResult(result.error);
    }

    return const SuccessResult(null);
  }
}
