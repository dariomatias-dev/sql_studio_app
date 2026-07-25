import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_basic_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_basic_suggestions_repository_impl.dart';

class _MockDatasource extends Mock
    implements SqlBasicSuggestionsLocalDatasource {}

class _MockLogger extends Mock implements Logger {}

void main() {
  late _MockDatasource datasource;
  late SqlBasicSuggestionsRepositoryImpl repository;

  setUp(() {
    datasource = _MockDatasource();
    repository = SqlBasicSuggestionsRepositoryImpl(datasource, _MockLogger());
  });

  group('load', () {
    test('returns the stored suggestions when present', () {
      when(() => datasource.getSuggestions()).thenReturn(['SELECT', 'FROM']);

      final result = repository.load();

      expect(result, completion(isA<SuccessResult<List<String>>>()));
    });

    test('falls back to the bundled defaults when storage is empty', () async {
      when(() => datasource.getSuggestions()).thenReturn([]);

      final result = await repository.load() as SuccessResult<List<String>>;

      expect(result.value, defaultSqlBasicSuggestions);
    });

    test(
      'fails with failedToLoadBasicSuggestions when reading throws',
      () async {
        when(() => datasource.getSuggestions()).thenThrow(Exception('boom'));

        final result = await repository.load() as FailureResult<List<String>>;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToLoadBasicSuggestions,
        );
      },
    );
  });

  group('save', () {
    test('succeeds when the write completes', () async {
      when(
        () => datasource.setSuggestions(any()),
      ).thenAnswer((_) async {});

      final result = await repository.save(['SELECT']);

      expect(result.isSuccess, isTrue);
    });

    test(
      'fails with failedToUpdateBasicSuggestions when writing throws',
      () async {
        when(
          () => datasource.setSuggestions(any()),
        ).thenThrow(Exception('boom'));

        final result = await repository.save(['SELECT']) as FailureResult<void>;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToUpdateBasicSuggestions,
        );
      },
    );
  });
}
