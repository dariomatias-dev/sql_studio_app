import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/add_sql_advanced_suggestion_usecase.dart';

class _MockRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

void main() {
  test('forwards the suggestion to the repository', () async {
    final repository = _MockRepository();
    final useCase = AddSqlAdvancedSuggestionUseCase(repository);
    final suggestion = SqlAdvancedSuggestionModel(
      label: 'A',
      code: 'SELECT 1',
      orderIndex: 0,
    );

    when(
      () => repository.create(suggestion),
    ).thenAnswer((_) async => const SuccessResult(null));

    await useCase(suggestion);

    verify(() => repository.create(suggestion)).called(1);
  });
}
