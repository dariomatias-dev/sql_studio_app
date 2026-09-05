import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_advanced_suggestions_repository_impl.dart';

class _MockDatasource extends Mock
    implements SqlAdvancedSuggestionsLocalDatasource {}

class _MockLogger extends Mock implements AppLogger {}

void main() {
  late _MockDatasource datasource;
  late SqlAdvancedSuggestionsRepositoryImpl repository;

  final suggestion = SqlAdvancedSuggestionModel(
    label: 'A',
    code: 'SELECT 1',
    orderIndex: 0,
  );

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<Map<String, dynamic>>[]);
  });

  setUp(() {
    datasource = _MockDatasource();
    repository = SqlAdvancedSuggestionsRepositoryImpl(
      datasource,
      _MockLogger(),
    );
  });

  group('getAll', () {
    test('maps every stored row into a model', () async {
      when(
        () => datasource.getAll(),
      ).thenAnswer((_) async => [suggestion.toMap()]);

      final result =
          await repository.getAll()
              as SuccessResult<List<SqlAdvancedSuggestionModel>>;

      expect(result.value.single.label, 'A');
    });

    test('seeds and persists the defaults when the store is empty', () async {
      when(() => datasource.getAll()).thenAnswer((_) async => []);
      when(() => datasource.insertAll(any())).thenAnswer(
        (_) async => List.filled(defaultSqlAdvancedSuggestions.length, 1),
      );

      final result =
          await repository.getAll()
              as SuccessResult<List<SqlAdvancedSuggestionModel>>;

      expect(result.value.length, defaultSqlAdvancedSuggestions.length);
      expect(
        result.value.map((s) => s.label),
        defaultSqlAdvancedSuggestions.map((s) => s.label),
      );
      verify(
        () => datasource.insertAll(
          defaultSqlAdvancedSuggestions.map((s) => s.toMap()).toList(),
        ),
      ).called(1);
    });

    test(
      'fails with failedToLoadAdvancedSuggestions when reading throws',
      () async {
        when(() => datasource.getAll()).thenThrow(Exception('boom'));

        final result =
            await repository.getAll()
                as FailureResult<List<SqlAdvancedSuggestionModel>>;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToLoadAdvancedSuggestions,
        );
      },
    );
  });

  group('create', () {
    test('forwards the model as a map', () async {
      when(() => datasource.insert(any())).thenAnswer((_) async => 1);

      final result = await repository.create(suggestion);

      expect(result.isSuccess, isTrue);
      verify(() => datasource.insert(suggestion.toMap())).called(1);
    });

    test(
      'fails with failedToAddAdvancedSuggestion when inserting throws',
      () async {
        when(() => datasource.insert(any())).thenThrow(Exception('boom'));

        final result = await repository.create(suggestion) as FailureResult;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToAddAdvancedSuggestion,
        );
      },
    );
  });

  group('addAll', () {
    test('skips the datasource call for an empty list', () async {
      final result = await repository.addAll(const []);

      expect(result.isSuccess, isTrue);
      verifyNever(() => datasource.insertAll(any()));
    });

    test('forwards every model as a map when non-empty', () async {
      when(() => datasource.insertAll(any())).thenAnswer((_) async => [1]);

      final result = await repository.addAll([suggestion]);

      expect(result.isSuccess, isTrue);
      verify(() => datasource.insertAll([suggestion.toMap()])).called(1);
    });

    test(
      'fails with failedToSaveAllAdvancedSuggestions when inserting throws',
      () async {
        when(() => datasource.insertAll(any())).thenThrow(Exception('boom'));

        final result = await repository.addAll([suggestion]) as FailureResult;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToSaveAllAdvancedSuggestions,
        );
      },
    );
  });

  group('update', () {
    test('forwards the model as a map', () async {
      when(() => datasource.update(any())).thenAnswer((_) async => 1);

      final result = await repository.update(suggestion);

      expect(result.isSuccess, isTrue);
      verify(() => datasource.update(suggestion.toMap())).called(1);
    });

    test(
      'fails with failedToUpdateAdvancedSuggestion when updating throws',
      () async {
        when(() => datasource.update(any())).thenThrow(Exception('boom'));

        final result = await repository.update(suggestion) as FailureResult;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToUpdateAdvancedSuggestion,
        );
      },
    );
  });

  group('updateAll', () {
    test('skips the datasource call for an empty list', () async {
      final result = await repository.updateAll(const []);

      expect(result.isSuccess, isTrue);
      verifyNever(() => datasource.updateAll(any()));
    });

    test('forwards every model as a map when non-empty', () async {
      when(() => datasource.updateAll(any())).thenAnswer((_) async => [1]);

      final result = await repository.updateAll([suggestion]);

      expect(result.isSuccess, isTrue);
      verify(() => datasource.updateAll([suggestion.toMap()])).called(1);
    });

    test(
      'fails with failedToReorderAdvancedSuggestions when updating throws',
      () async {
        when(() => datasource.updateAll(any())).thenThrow(Exception('boom'));

        final result =
            await repository.updateAll([suggestion]) as FailureResult;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToReorderAdvancedSuggestions,
        );
      },
    );
  });

  group('delete', () {
    test('forwards the id', () async {
      when(() => datasource.deleteById(any())).thenAnswer((_) async => 1);

      final result = await repository.delete('abc');

      expect(result.isSuccess, isTrue);
      verify(() => datasource.deleteById('abc')).called(1);
    });

    test(
      'fails with failedToRemoveAdvancedSuggestion when deleting throws',
      () async {
        when(
          () => datasource.deleteById(any()),
        ).thenThrow(Exception('boom'));

        final result = await repository.delete('abc') as FailureResult;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToRemoveAdvancedSuggestion,
        );
      },
    );
  });

  group('clear', () {
    test('delegates to the datasource', () async {
      when(() => datasource.clear()).thenAnswer((_) async {});

      final result = await repository.clear();

      expect(result.isSuccess, isTrue);
      verify(() => datasource.clear()).called(1);
    });

    test('fails with unableToClear when clearing throws', () async {
      when(() => datasource.clear()).thenThrow(Exception('boom'));

      final result = await repository.clear() as FailureResult;

      expect(result.error.type, AppLocalizationsKey.unableToClear);
    });
  });
}
