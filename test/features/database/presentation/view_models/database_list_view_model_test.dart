import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/create_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_database_by_name_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_databases_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/toggle_database_favorite_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/providers.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

void main() {
  late _MockDatabaseRepository repository;

  DatabaseModel model({
    required String label,
    required String name,
    bool isFavorite = false,
  }) {
    return DatabaseModel(label: label, name: name, isFavorite: isFavorite);
  }

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        getDatabasesUseCaseProvider.overrideWithValue(
          GetDatabasesUseCase(repository),
        ),
        createDatabaseUseCaseProvider.overrideWithValue(
          CreateDatabaseUseCase(repository),
        ),
        getDatabaseByNameUseCaseProvider.overrideWithValue(
          GetDatabaseByNameUseCase(repository),
        ),
        deleteDatabaseUseCaseProvider.overrideWithValue(
          DeleteDatabaseUseCase(repository),
        ),
        toggleDatabaseFavoriteUseCaseProvider.overrideWithValue(
          ToggleDatabaseFavoriteUseCase(repository),
        ),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  setUpAll(() {
    registerFallbackValue(model(label: 'fallback', name: 'fallback'));
  });

  setUp(() {
    repository = _MockDatabaseRepository();
  });

  group('loadDatabases', () {
    test('splits the loaded databases into favorites and others', () async {
      final favorite = model(label: 'Todo', name: 'todo', isFavorite: true);
      final other = model(label: 'Contacts', name: 'contacts');

      when(
        () => repository.getAll(),
      ).thenAnswer((_) async => SuccessResult([favorite, other]));

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);

      final result = await notifier.loadDatabases();
      final state = container.read(databaseListViewModelProvider);

      expect(result.isSuccess, isTrue);
      expect(state.favorites.single.name, 'todo');
      expect(state.others.single.name, 'contacts');
      expect(state.isLoading, isFalse);
    });

    test('returns a failure and leaves the lists empty on error', () async {
      when(() => repository.getAll()).thenAnswer(
        (_) async => const FailureResult(
          DatabaseFailure(AppLocalizationsKey.fetchDatabasesError),
        ),
      );

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);

      final result = await notifier.loadDatabases();
      final state = container.read(databaseListViewModelProvider);

      expect(result.isFailure, isTrue);
      expect(state.favorites, isEmpty);
      expect(state.others, isEmpty);
    });

    test(
      'does not run a second load while one is already in progress',
      () async {
        when(() => repository.getAll()).thenAnswer((_) async {
          return const SuccessResult(<DatabaseModel>[]);
        });

        final container = buildContainer();
        final notifier = container.read(databaseListViewModelProvider.notifier);

        final first = notifier.loadDatabases();
        final second = notifier.loadDatabases();

        await Future.wait([first, second]);

        verify(() => repository.getAll()).called(1);
      },
    );
  });

  group('create', () {
    test('adds a favorite database to the favorites list', () async {
      when(
        () => repository.create(any()),
      ).thenAnswer((_) async => const SuccessResult(null));

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);
      final newDb = model(label: 'Todo', name: 'todo', isFavorite: true);

      final result = await notifier.create(newDb);
      final state = container.read(databaseListViewModelProvider);

      expect(result.isSuccess, isTrue);
      expect(state.favorites.single.name, 'todo');
      expect(state.others, isEmpty);
    });

    test('does not add the database when creation fails', () async {
      when(() => repository.create(any())).thenAnswer(
        (_) async => const FailureResult(
          DatabaseFailure(AppLocalizationsKey.databaseCreationError),
        ),
      );

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);

      final result = await notifier.create(model(label: 'Todo', name: 'todo'));
      final state = container.read(databaseListViewModelProvider);

      expect(result.isFailure, isTrue);
      expect(state.favorites, isEmpty);
      expect(state.others, isEmpty);
    });
  });

  group('delete', () {
    test('removes the database from its list on success', () async {
      final existing = model(label: 'Todo', name: 'todo');

      when(
        () => repository.getAll(),
      ).thenAnswer((_) async => SuccessResult([existing]));
      when(
        () => repository.dropDatabaseFile(any()),
      ).thenAnswer((_) async => const SuccessResult(null));
      when(
        () => repository.delete(any()),
      ).thenAnswer((_) async => const SuccessResult(null));

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);
      await notifier.loadDatabases();

      final result = await notifier.delete(existing);
      final state = container.read(databaseListViewModelProvider);

      expect(result.isSuccess, isTrue);
      expect(state.others, isEmpty);
    });
  });

  group('toggleFavorite', () {
    test('moves a database from others to favorites', () async {
      final existing = model(label: 'Todo', name: 'todo');

      when(
        () => repository.getAll(),
      ).thenAnswer((_) async => SuccessResult([existing]));
      when(
        () => repository.toggleFavorite(any()),
      ).thenAnswer((_) async => const SuccessResult(null));

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);
      await notifier.loadDatabases();

      final result = await notifier.toggleFavorite(existing);
      final state = container.read(databaseListViewModelProvider);

      expect(result.isSuccess, isTrue);
      expect(state.others, isEmpty);
      expect(state.favorites.single.isFavorite, isTrue);
    });
  });

  group('setFilter', () {
    test('filters both lists by a case-insensitive name match', () async {
      when(() => repository.getAll()).thenAnswer(
        (_) async => SuccessResult([
          model(label: 'Todo', name: 'todo_list', isFavorite: true),
          model(label: 'Contacts', name: 'contacts'),
        ]),
      );

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);
      await notifier.loadDatabases();

      notifier.setFilter('TODO');
      final state = container.read(databaseListViewModelProvider);

      expect(state.favorites.single.name, 'todo_list');
      expect(state.others, isEmpty);
    });

    test('does nothing when the filter is unchanged', () async {
      when(
        () => repository.getAll(),
      ).thenAnswer((_) async => const SuccessResult(<DatabaseModel>[]));

      final container = buildContainer();
      final notifier = container.read(databaseListViewModelProvider.notifier);
      await notifier.loadDatabases();

      notifier.setFilter('');

      // No exception and the state remains the same empty-filter state.
      expect(container.read(databaseListViewModelProvider).filter, '');
    });
  });
}
