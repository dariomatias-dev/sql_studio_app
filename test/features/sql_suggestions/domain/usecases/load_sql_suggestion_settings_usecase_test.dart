import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_suggestion_settings_usecase.dart';

class _MockRepository extends Mock implements SqlSuggestionSettingsRepository {}

void main() {
  test('returns the repository result', () async {
    final repository = _MockRepository();
    final useCase = LoadSqlSuggestionSettingsUseCase(repository);
    const settings = SqlSuggestionSettingsEntity(useAdvancedSuggestions: true);

    when(
      repository.load,
    ).thenAnswer((_) async => const SuccessResult(settings));

    final result =
        await useCase() as SuccessResult<SqlSuggestionSettingsEntity>;

    expect(result.value, same(settings));
  });
}
