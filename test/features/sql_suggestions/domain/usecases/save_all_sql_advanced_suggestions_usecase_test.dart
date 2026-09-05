import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_all_sql_advanced_suggestions_usecase.dart';

class _MockSqlAdvancedSuggestionsRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  late _MockSqlAdvancedSuggestionsRepository repository;
  late SaveAllSqlAdvancedSuggestionsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(<SqlAdvancedSuggestionEntity>[]);
  });

  setUp(() {
    repository = _MockSqlAdvancedSuggestionsRepository();
    useCase = SaveAllSqlAdvancedSuggestionsUseCase(repository);
    when(
      () => repository.clear(),
    ).thenAnswer((_) async => const SuccessResult(null));
    when(
      () => repository.addAll(any()),
    ).thenAnswer((_) async => const SuccessResult(null));
  });

  test('clears storage before writing the new suggestions', () async {
    final suggestions = [
      SqlAdvancedSuggestionEntity(label: 'A', code: 'SELECT 1', orderIndex: 0),
    ];

    await useCase(suggestions);

    verifyInOrder([
      () => repository.clear(),
      () => repository.addAll(suggestions),
    ]);
  });

  test('still clears storage when given an empty list', () async {
    await useCase(const []);

    verify(() => repository.clear()).called(1);
    verify(() => repository.addAll(const [])).called(1);
  });

  test('short-circuits and skips addAll when clearing fails', () async {
    when(() => repository.clear()).thenAnswer(
      (_) async =>
          const FailureResult(AppFailure(AppLocalizationsKey.unableToClear)),
    );

    final result = await useCase(const []) as FailureResult;

    expect(result.error.type, AppLocalizationsKey.unableToClear);
    verifyNever(() => repository.addAll(any()));
  });
}
