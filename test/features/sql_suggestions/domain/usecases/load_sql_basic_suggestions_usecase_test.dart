import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_basic_suggestions_usecase.dart';

class _MockRepository extends Mock implements SqlBasicSuggestionsRepository {}

void main() {
  test('returns the repository result', () async {
    final repository = _MockRepository();
    final useCase = LoadSqlBasicSuggestionsUseCase(repository);

    when(
      repository.load,
    ).thenAnswer((_) async => const SuccessResult(['SELECT']));

    final result = await useCase() as SuccessResult<List<String>>;

    expect(result.value, ['SELECT']);
  });
}
