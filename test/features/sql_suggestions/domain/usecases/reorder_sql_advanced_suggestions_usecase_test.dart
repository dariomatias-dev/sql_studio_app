import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';

class _MockSqlAdvancedSuggestionsRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  late _MockSqlAdvancedSuggestionsRepository repository;
  late ReorderSqlAdvancedSuggestionsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      SqlAdvancedSuggestionEntity(label: '', code: '', orderIndex: 0),
    );
  });

  setUp(() {
    repository = _MockSqlAdvancedSuggestionsRepository();
    useCase = ReorderSqlAdvancedSuggestionsUseCase(repository);
    when(
      () => repository.updateAll(any()),
    ).thenAnswer((_) async => const SuccessResult(null));
  });

  test(
    'assigns each suggestion its position in the new order and persists it',
    () async {
      final newOrder = [
        SqlAdvancedSuggestionEntity(
          label: 'C',
          code: 'SELECT 3',
          orderIndex: 2,
        ),
        SqlAdvancedSuggestionEntity(
          label: 'A',
          code: 'SELECT 1',
          orderIndex: 0,
        ),
        SqlAdvancedSuggestionEntity(
          label: 'B',
          code: 'SELECT 2',
          orderIndex: 1,
        ),
      ];

      final result =
          await useCase(newOrder)
              as SuccessResult<List<SqlAdvancedSuggestionEntity>>;

      expect(result.value.map((s) => s.label).toList(), ['C', 'A', 'B']);
      expect(result.value.map((s) => s.orderIndex).toList(), [0, 1, 2]);
    },
  );

  test('persists the whole new order via a single batch call', () async {
    final newOrder = [
      SqlAdvancedSuggestionEntity(label: 'A', code: 'SELECT 1', orderIndex: 0),
      SqlAdvancedSuggestionEntity(label: 'B', code: 'SELECT 2', orderIndex: 1),
    ];

    await useCase(newOrder);

    verify(() => repository.updateAll(any())).called(1);
  });

  test('returns an empty list without touching the repository when given '
      'an empty order', () async {
    final result =
        await useCase(const [])
            as SuccessResult<List<SqlAdvancedSuggestionEntity>>;

    expect(result.value, isEmpty);
    verifyNever(() => repository.updateAll(any()));
  });

  test('propagates the failure when persisting fails', () async {
    when(() => repository.updateAll(any())).thenAnswer(
      (_) async => const FailureResult(
        AppFailure(AppLocalizationsKey.failedToReorderAdvancedSuggestions),
      ),
    );

    final newOrder = [
      SqlAdvancedSuggestionEntity(label: 'A', code: 'SELECT 1', orderIndex: 0),
    ];

    final result = await useCase(newOrder) as FailureResult;

    expect(
      result.error.type,
      AppLocalizationsKey.failedToReorderAdvancedSuggestions,
    );
  });
}
