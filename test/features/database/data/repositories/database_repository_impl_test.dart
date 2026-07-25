import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/datasources/database_local_datasource.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/data/repositories/database_repository_impl.dart';

class _MockDatabaseLocalDatasource extends Mock
    implements DatabaseLocalDatasource {}

class _MockLogger extends Mock implements Logger {}

void main() {
  late _MockDatabaseLocalDatasource datasource;
  late DatabaseRepositoryImpl repository;

  final model = DatabaseModel(label: 'Todo', name: 'todo');

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    datasource = _MockDatabaseLocalDatasource();
    repository = DatabaseRepositoryImpl(datasource, _MockLogger());
  });

  group('create', () {
    test('succeeds when the insert completes', () async {
      when(() => datasource.insert(any())).thenAnswer((_) async => 1);

      final result = await repository.create(model);

      expect(result.isSuccess, isTrue);
    });

    test('fails with databaseCreationError when the insert throws', () async {
      when(() => datasource.insert(any())).thenThrow(Exception('disk full'));

      final result = await repository.create(model) as FailureResult<void>;

      expect(result.error.type, AppLocalizationsKey.databaseCreationError);
      expect(result.error.args['databaseName'], 'todo');
    });
  });

  group('getAll', () {
    test('maps every row into a DatabaseModel on success', () async {
      when(
        () => datasource.getAll(orderBy: any(named: 'orderBy')),
      ).thenAnswer((_) async => [model.toMap()]);

      final result =
          await repository.getAll() as SuccessResult<List<DatabaseModel>>;

      expect(result.value.single.name, 'todo');
    });

    test('fails with fetchDatabasesError when the query throws', () async {
      when(
        () => datasource.getAll(orderBy: any(named: 'orderBy')),
      ).thenThrow(Exception('io error'));

      final result =
          await repository.getAll() as FailureResult<List<DatabaseModel>>;

      expect(result.error.type, AppLocalizationsKey.fetchDatabasesError);
    });
  });

  group('getByName', () {
    test('returns the model when a row is found', () async {
      when(
        () => datasource.getWhere(
          conditions: any(named: 'conditions'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => [model.toMap()]);

      final result =
          await repository.getByName('todo') as SuccessResult<DatabaseModel?>;

      expect(result.value?.name, 'todo');
    });

    test('returns a null value when no row is found', () async {
      when(
        () => datasource.getWhere(
          conditions: any(named: 'conditions'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => []);

      final result =
          await repository.getByName('missing')
              as SuccessResult<DatabaseModel?>;

      expect(result.value, isNull);
    });
  });

  group('delete', () {
    test('succeeds when a row was actually deleted', () async {
      when(() => datasource.delete(any())).thenAnswer((_) async => 1);

      final result = await repository.delete(model);

      expect(result.isSuccess, isTrue);
    });

    test('fails with noRecordDeleted when no row matched', () async {
      when(() => datasource.delete(any())).thenAnswer((_) async => 0);

      final result = await repository.delete(model) as FailureResult<void>;

      expect(result.error.type, AppLocalizationsKey.noRecordDeleted);
    });

    test('fails with deleteDatabaseError when the delete throws', () async {
      when(() => datasource.delete(any())).thenThrow(Exception('locked'));

      final result = await repository.delete(model) as FailureResult<void>;

      expect(result.error.type, AppLocalizationsKey.deleteDatabaseError);
    });
  });

  group('toggleFavorite', () {
    test('succeeds when a row was actually updated', () async {
      when(() => datasource.update(any())).thenAnswer((_) async => 1);

      final result = await repository.toggleFavorite(model);

      expect(result.isSuccess, isTrue);
    });

    test(
      'fails with toggleDatabaseFavoriteError when no row matched',
      () async {
        when(() => datasource.update(any())).thenAnswer((_) async => 0);

        final result =
            await repository.toggleFavorite(model) as FailureResult<void>;

        expect(
          result.error.type,
          AppLocalizationsKey.toggleDatabaseFavoriteError,
        );
      },
    );

    test(
      'fails with toggleDatabaseFavoriteError when the update throws',
      () async {
        when(() => datasource.update(any())).thenThrow(Exception('locked'));

        final result = await repository.toggleFavorite(model);

        expect(result.isFailure, isTrue);
      },
    );
  });

  group('dropDatabaseFile', () {
    test('succeeds when the file is dropped', () async {
      when(() => datasource.dropDatabaseFile(any())).thenAnswer((_) async {});

      final result = await repository.dropDatabaseFile(model);

      expect(result.isSuccess, isTrue);
    });

    test('fails with deleteDatabaseError when dropping throws', () async {
      when(
        () => datasource.dropDatabaseFile(any()),
      ).thenThrow(Exception('missing file'));

      final result =
          await repository.dropDatabaseFile(model) as FailureResult<void>;

      expect(result.error.type, AppLocalizationsKey.deleteDatabaseError);
    });
  });
}
