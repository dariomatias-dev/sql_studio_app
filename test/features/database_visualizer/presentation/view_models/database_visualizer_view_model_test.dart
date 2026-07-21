import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/usecases/get_database_structure_usecase.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';

void main() {
  Future<List<TableInfoModel>> fakeGetStructure(String databaseName) async {
    return [
      TableInfoModel(
        name: databaseName,
        columns: [ColumnInfoModel(name: 'id', type: 'TEXT')],
      ),
    ];
  }

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        getDatabaseStructureUseCaseProvider.overrideWithValue(
          GetDatabaseStructureUseCase(fakeGetStructure),
        ),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  test('load() populates the state with the loaded tables', () async {
    final container = buildContainer();
    final notifier = container.read(
      databaseVisualizerViewModelProvider.notifier,
    );

    await notifier.load('todo_list');

    final state = container.read(databaseVisualizerViewModelProvider);

    expect(state.tables, isNotNull);
    expect(state.tables!.single.name, 'todo_list');
  });

  test(
    'load() can run again on the same notifier instance after '
    'ref.invalidate recreates it — regression test for the '
    'LateInitializationError previously thrown by a cached late field',
    () async {
      final container = buildContainer();

      await container
          .read(databaseVisualizerViewModelProvider.notifier)
          .load('todo_list');

      container.invalidate(databaseVisualizerViewModelProvider);

      // Reading after invalidate rebuilds the Notifier; this must not
      // throw even though `build()` runs again.
      await container
          .read(databaseVisualizerViewModelProvider.notifier)
          .load('contacts');

      final state = container.read(databaseVisualizerViewModelProvider);

      expect(state.tables!.single.name, 'contacts');
    },
  );
}
