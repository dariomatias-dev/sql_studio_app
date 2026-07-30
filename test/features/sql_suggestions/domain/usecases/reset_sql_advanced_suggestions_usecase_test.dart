import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reset_sql_advanced_suggestions_usecase.dart';

class _MockSqlAdvancedSuggestionsRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  late _MockSqlAdvancedSuggestionsRepository repository;
  late ResetSqlAdvancedSuggestionsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(<SqlAdvancedSuggestionModel>[]);
  });

  setUp(() {
    repository = _MockSqlAdvancedSuggestionsRepository();
    useCase = ResetSqlAdvancedSuggestionsUseCase(repository);
    when(
      () => repository.clear(),
    ).thenAnswer((_) async => const SuccessResult(null));
    when(
      () => repository.addAll(any()),
    ).thenAnswer((_) async => const SuccessResult(null));
  });

  test('clears storage before writing back the bundled defaults', () async {
    await useCase();

    verifyInOrder([() => repository.clear(), () => repository.addAll(any())]);
  });

  test('returns the same suggestions as the bundled defaults', () async {
    final result =
        await useCase() as SuccessResult<List<SqlAdvancedSuggestionModel>>;

    expect(result.value.map((s) => s.label).toList(), [
      for (final s in defaultSqlAdvancedSuggestions) s.label,
    ]);
    expect(result.value.length, defaultSqlAdvancedSuggestions.length);
  });

  test('short-circuits and skips addAll when clearing fails', () async {
    when(() => repository.clear()).thenAnswer(
      (_) async =>
          const FailureResult(AppFailure(AppLocalizationsKey.unableToClear)),
    );

    final result = await useCase() as FailureResult;

    expect(result.error.type, AppLocalizationsKey.unableToClear);
    verifyNever(() => repository.addAll(any()));
  });

  test('propagates the failure when writing the defaults fails', () async {
    when(() => repository.addAll(any())).thenAnswer(
      (_) async => const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveAllAdvancedSuggestions),
      ),
    );

    final result = await useCase() as FailureResult;

    expect(
      result.error.type,
      AppLocalizationsKey.failedToSaveAllAdvancedSuggestions,
    );
  });
}
