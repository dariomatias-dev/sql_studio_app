import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  late _MockSqlCommandsRepository repository;

  Future<ProviderContainer> buildContainer() async {
    final prefs = await fakeSharedPreferencesService();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(prefs),
        sqlCommandsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  setUp(() {
    repository = _MockSqlCommandsRepository();
  });

  group('runQuery', () {
    test('fails immediately with no active database selected', () async {
      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier);

      await notifier.runQuery('SELECT 1;');

      final state = container.read(sqlCommandsViewModelProvider);
      expect(state.error, AppLocalizationsKey.noDatabaseSelected);
      verifyNever(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      );
    });

    test('stores the result and clears any prior error on success', () async {
      const success = DatabaseSuccess(
        result: [
          {'id': 1},
        ],
      );

      when(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).thenAnswer((_) async => const SuccessResult(success));

      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier)
        ..activeDatabase = 'todo_list';

      await notifier.runQuery('SELECT * FROM tasks;');

      final state = container.read(sqlCommandsViewModelProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
      expect(state.lastQuery, 'SELECT * FROM tasks;');
      expect((state.result! as SuccessResult).value, same(success));
    });

    test('stores the error and clears any prior result on failure', () async {
      when(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).thenAnswer(
        (_) async => const FailureResult(
          DatabaseFailure(AppLocalizationsKey.sqlExecutionError),
        ),
      );

      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier)
        ..activeDatabase = 'todo_list';

      await notifier.runQuery('SELECT * FROM missing;');

      final state = container.read(sqlCommandsViewModelProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, AppLocalizationsKey.sqlExecutionError);
      expect(state.result, isNull);
    });
  });

  group('getTableColumns', () {
    test('returns an empty list with no active database selected', () async {
      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier);

      final columns = await notifier.getTableColumns('tasks');

      expect(columns, isEmpty);
      final state = container.read(sqlCommandsViewModelProvider);
      expect(state.error, AppLocalizationsKey.noDatabaseSelected);
    });

    test('returns the repository columns for the active database', () async {
      when(
        () => repository.getTableColumns(
          databaseName: any(named: 'databaseName'),
          tableName: any(named: 'tableName'),
        ),
      ).thenAnswer((_) async => ['id', 'title']);

      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier)
        ..activeDatabase = 'todo_list';

      final columns = await notifier.getTableColumns('tasks');

      expect(columns, ['id', 'title']);
    });
  });

  group('resetDatabase', () {
    test(
      'does nothing when the active database is not a default one',
      () async {
        final container = await buildContainer();
        final notifier = container.read(sqlCommandsViewModelProvider.notifier)
          ..activeDatabase = 'my_custom_db';

        await notifier.resetDatabase();

        verifyNever(() => repository.resetDefaultDatabase(any()));
      },
    );

    test('stores a success result when resetting a default database', () async {
      when(
        () => repository.resetDefaultDatabase(any()),
      ).thenAnswer((_) async => const SuccessResult(null));

      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier)
        ..activeDatabase = 'to_do_list';

      final result = await notifier.resetDatabase();

      final state = container.read(sqlCommandsViewModelProvider);
      expect(state.isLoading, isFalse);
      expect(state.result, isNull);
      expect(result.isSuccess, isTrue);
    });
  });

  group('clearResult', () {
    test('clears a stored result and error', () async {
      when(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).thenAnswer(
        (_) async => const FailureResult(
          DatabaseFailure(AppLocalizationsKey.sqlExecutionError),
        ),
      );

      final container = await buildContainer();
      final notifier = container.read(sqlCommandsViewModelProvider.notifier)
        ..activeDatabase = 'todo_list';
      await notifier.runQuery('SELECT * FROM missing;');

      notifier.clearResult();

      final state = container.read(sqlCommandsViewModelProvider);
      expect(state.result, isNull);
      expect(state.error, isNull);
    });
  });
}
