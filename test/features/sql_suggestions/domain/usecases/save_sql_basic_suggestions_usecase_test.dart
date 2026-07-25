import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_sql_basic_suggestions_usecase.dart';

class _MockRepository extends Mock implements SqlBasicSuggestionsRepository {}

void main() {
  test('forwards the suggestions to the repository', () async {
    final repository = _MockRepository();
    final useCase = SaveSqlBasicSuggestionsUseCase(repository);

    when(
      () => repository.save(['SELECT']),
    ).thenAnswer((_) async => const SuccessResult(null));

    final result = await useCase(['SELECT']);

    expect(result.isSuccess, isTrue);
    verify(() => repository.save(['SELECT'])).called(1);
  });
}
