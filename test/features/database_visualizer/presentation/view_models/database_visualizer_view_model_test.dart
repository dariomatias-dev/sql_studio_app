import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/usecases/get_database_structure_usecase.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';

class _MockDatabaseStructureRepository extends Mock
    implements DatabaseStructureRepository {}

void main() {
  late _MockDatabaseStructureRepository repository;

  setUp(() {
    repository = _MockDatabaseStructureRepository();
  });

  List<TableInfoModel> tablesFor(String databaseName) => [
    TableInfoModel(
      name: databaseName,
      columns: [ColumnInfoModel(name: 'id', type: 'TEXT')],
    ),
  ];

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        getDatabaseStructureUseCaseProvider.overrideWithValue(
          GetDatabaseStructureUseCase(repository),
        ),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  test('load() populates the state with the loaded tables', () async {
    when(
      () => repository.getStructure('todo_list'),
    ).thenAnswer((_) async => SuccessResult(tablesFor('todo_list')));

    final container = buildContainer();
    final notifier = container.read(
      databaseVisualizerViewModelProvider.notifier,
    );

    await notifier.load('todo_list');

    final state = container.read(databaseVisualizerViewModelProvider);

    expect(state.tables, isNotNull);
    expect(state.tables!.single.name, 'todo_list');
  });

  test('load() clears tables and surfaces the failure on error', () async {
    const failure = FailureResult<List<TableInfoModel>>(
      DatabaseFailure(AppLocalizationsKey.failedToLoadDatabaseStructure),
    );

    when(
      () => repository.getStructure('todo_list'),
    ).thenAnswer((_) async => failure);

    final container = buildContainer();
    final notifier = container.read(
      databaseVisualizerViewModelProvider.notifier,
    );

    final result = await notifier.load('todo_list');

    final state = container.read(databaseVisualizerViewModelProvider);

    expect(result.isFailure, isTrue);
    expect(state.tables, isEmpty);
  });

  test(
    'load() can run again on the same notifier instance after '
    'ref.invalidate recreates it — regression test for the '
    'LateInitializationError previously thrown by a cached late field',
    () async {
      when(
        () => repository.getStructure('todo_list'),
      ).thenAnswer((_) async => SuccessResult(tablesFor('todo_list')));
      when(
        () => repository.getStructure('contacts'),
      ).thenAnswer((_) async => SuccessResult(tablesFor('contacts')));

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
