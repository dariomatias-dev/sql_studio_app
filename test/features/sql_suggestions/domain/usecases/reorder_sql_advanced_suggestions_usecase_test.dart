import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';

class _MockSqlAdvancedSuggestionsRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  late _MockSqlAdvancedSuggestionsRepository repository;
  late ReorderSqlAdvancedSuggestionsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      SqlAdvancedSuggestionModel(label: '', code: '', orderIndex: 0),
    );
  });

  setUp(() {
    repository = _MockSqlAdvancedSuggestionsRepository();
    useCase = ReorderSqlAdvancedSuggestionsUseCase(repository);
    when(() => repository.update(any())).thenAnswer((_) async {});
  });

  test(
    'assigns each suggestion its position in the new order and persists it',
    () async {
      final newOrder = [
        SqlAdvancedSuggestionModel(label: 'C', code: 'SELECT 3', orderIndex: 2),
        SqlAdvancedSuggestionModel(label: 'A', code: 'SELECT 1', orderIndex: 0),
        SqlAdvancedSuggestionModel(label: 'B', code: 'SELECT 2', orderIndex: 1),
      ];

      final updated = await useCase(newOrder);

      expect(updated.map((s) => s.label).toList(), ['C', 'A', 'B']);
      expect(updated.map((s) => s.orderIndex).toList(), [0, 1, 2]);
    },
  );

  test('persists every suggestion via the repository', () async {
    final newOrder = [
      SqlAdvancedSuggestionModel(label: 'A', code: 'SELECT 1', orderIndex: 0),
      SqlAdvancedSuggestionModel(label: 'B', code: 'SELECT 2', orderIndex: 1),
    ];

    await useCase(newOrder);

    verify(() => repository.update(any())).called(newOrder.length);
  });

  test('returns an empty list without touching the repository when given '
      'an empty order', () async {
    final updated = await useCase(const []);

    expect(updated, isEmpty);
    verifyNever(() => repository.update(any()));
  });
}
