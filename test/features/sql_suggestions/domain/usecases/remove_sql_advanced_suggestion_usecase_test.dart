import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/remove_sql_advanced_suggestion_usecase.dart';

class _MockRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  test('forwards the id to the repository', () async {
    final repository = _MockRepository();
    final useCase = RemoveSqlAdvancedSuggestionUseCase(repository);

    when(
      () => repository.delete('abc'),
    ).thenAnswer((_) async => const SuccessResult(null));

    await useCase('abc');

    verify(() => repository.delete('abc')).called(1);
  });
}
