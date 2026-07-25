import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_sql_suggestion_settings_usecase.dart';

class _MockRepository extends Mock implements SqlSuggestionSettingsRepository {}

void main() {
  test('forwards the settings to the repository', () async {
    final repository = _MockRepository();
    final useCase = SaveSqlSuggestionSettingsUseCase(repository);
    const settings = SqlSuggestionSettingsEntity(useAdvancedSuggestions: true);

    when(
      () => repository.save(settings),
    ).thenAnswer((_) async => const SuccessResult(null));

    final result = await useCase(settings);

    expect(result.isSuccess, isTrue);
    verify(() => repository.save(settings)).called(1);
  });
}
