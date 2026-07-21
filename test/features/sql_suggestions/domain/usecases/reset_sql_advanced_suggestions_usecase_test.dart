import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
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
    when(() => repository.clear()).thenAnswer((_) async {});
    when(() => repository.addAll(any())).thenAnswer((_) async {});
  });

  test('clears storage before writing back the bundled defaults', () async {
    await useCase();

    verifyInOrder([
      () => repository.clear(),
      () => repository.addAll(any()),
    ]);
  });

  test('returns the same suggestions as the bundled defaults', () async {
    final restored = await useCase();

    expect(restored.map((s) => s.label).toList(), [
      for (final s in defaultSqlAdvancedSuggestions) s.label,
    ]);
    expect(restored.length, defaultSqlAdvancedSuggestions.length);
  });
}
