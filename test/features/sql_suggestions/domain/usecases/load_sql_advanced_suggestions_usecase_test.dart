import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_advanced_suggestions_usecase.dart';

class _MockRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  test('returns every suggestion from the repository', () async {
    final repository = _MockRepository();
    final useCase = LoadSqlAdvancedSuggestionsUseCase(repository);
    final suggestion = SqlAdvancedSuggestionEntity(
      label: 'A',
      code: 'SELECT 1',
      orderIndex: 0,
    );

    when(
      repository.getAll,
    ).thenAnswer((_) async => SuccessResult([suggestion]));

    final result =
        await useCase() as SuccessResult<List<SqlAdvancedSuggestionEntity>>;

    expect(result.value.single, same(suggestion));
  });
}
