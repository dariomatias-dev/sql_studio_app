import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_advanced_suggestions_repository_impl.dart';

class _MockDatasource extends Mock
    implements SqlAdvancedSuggestionsLocalDatasource {}

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
    repository = SqlAdvancedSuggestionsRepositoryImpl(datasource);
  });

  test('getAll maps every stored row into a model', () async {
    when(
      () => datasource.getAll(),
    ).thenAnswer((_) async => [suggestion.toMap()]);

    final result = await repository.getAll();

    expect(result.single.label, 'A');
  });

  test(
    'getAll seeds and persists the defaults when the store is empty',
    () async {
      when(() => datasource.getAll()).thenAnswer((_) async => []);
      when(
        () => datasource.insertAll(any()),
      ).thenAnswer(
        (_) async => List.filled(defaultSqlAdvancedSuggestions.length, 1),
      );

      final result = await repository.getAll();

      expect(result.length, defaultSqlAdvancedSuggestions.length);
      expect(
        result.map((s) => s.label),
        defaultSqlAdvancedSuggestions.map((s) => s.label),
      );
      verify(
        () => datasource.insertAll(
          defaultSqlAdvancedSuggestions.map((s) => s.toMap()).toList(),
        ),
      ).called(1);
    },
  );

  test('create forwards the model as a map', () async {
    when(() => datasource.insert(any())).thenAnswer((_) async => 1);

    await repository.create(suggestion);

    verify(() => datasource.insert(suggestion.toMap())).called(1);
  });

  test('addAll skips the datasource call for an empty list', () async {
    await repository.addAll(const []);

    verifyNever(() => datasource.insertAll(any()));
  });

  test('addAll forwards every model as a map when non-empty', () async {
    when(
      () => datasource.insertAll(any()),
    ).thenAnswer((_) async => [1]);

    await repository.addAll([suggestion]);

    verify(() => datasource.insertAll([suggestion.toMap()])).called(1);
  });

  test('update forwards the model as a map', () async {
    when(() => datasource.update(any())).thenAnswer((_) async => 1);

    await repository.update(suggestion);

    verify(() => datasource.update(suggestion.toMap())).called(1);
  });

  test('delete forwards the id', () async {
    when(() => datasource.deleteById(any())).thenAnswer((_) async => 1);

    await repository.delete('abc');

    verify(() => datasource.deleteById('abc')).called(1);
  });

  test('clear delegates to the datasource', () async {
    when(() => datasource.clear()).thenAnswer((_) async {});

    await repository.clear();

    verify(() => datasource.clear()).called(1);
  });
}
