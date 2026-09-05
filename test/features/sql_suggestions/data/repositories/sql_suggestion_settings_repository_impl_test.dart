import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_suggestion_settings_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_suggestion_settings_repository_impl.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';

class _MockDatasource extends Mock
    implements SqlSuggestionSettingsLocalDatasource {}

class _MockLogger extends Mock implements AppLogger {}

void main() {
  late _MockDatasource datasource;
  late SqlSuggestionSettingsRepositoryImpl repository;

  setUp(() {
    datasource = _MockDatasource();
    repository = SqlSuggestionSettingsRepositoryImpl(
      datasource,
      _MockLogger(),
    );
  });

  group('load', () {
    test('builds an entity from the three persisted flags', () async {
      when(() => datasource.getUseBasicSuggestions()).thenReturn(false);
      when(() => datasource.getUseAdvancedSuggestions()).thenReturn(true);
      when(() => datasource.getUseCharacterSuggestions()).thenReturn(false);

      final result =
          await repository.load() as SuccessResult<SqlSuggestionSettingsEntity>;

      expect(result.value.useBasicSuggestions, isFalse);
      expect(result.value.useAdvancedSuggestions, isTrue);
      expect(result.value.useCharacterSuggestions, isFalse);
    });

    test('fails with failedToLoadSqlSuggestions when reading throws', () async {
      when(() => datasource.getUseBasicSuggestions()).thenThrow(
        Exception('boom'),
      );

      final result =
          await repository.load() as FailureResult<SqlSuggestionSettingsEntity>;

      expect(result.error.type, AppLocalizationsKey.failedToLoadSqlSuggestions);
    });
  });

  group('save', () {
    test('persists all three flags from the entity', () async {
      when(
        () => datasource.save(
          useBasic: any(named: 'useBasic'),
          useAdvanced: any(named: 'useAdvanced'),
          useCharacter: any(named: 'useCharacter'),
        ),
      ).thenAnswer((_) async {});

      const settings = SqlSuggestionSettingsEntity(
        useBasicSuggestions: false,
        useAdvancedSuggestions: true,
        useCharacterSuggestions: false,
      );

      final result = await repository.save(settings);

      expect(result.isSuccess, isTrue);
      verify(
        () => datasource.save(
          useBasic: false,
          useAdvanced: true,
          useCharacter: false,
        ),
      ).called(1);
    });

    test(
      'fails with failedToSaveSqlSuggestionsSettings when saving throws',
      () async {
        when(
          () => datasource.save(
            useBasic: any(named: 'useBasic'),
            useAdvanced: any(named: 'useAdvanced'),
            useCharacter: any(named: 'useCharacter'),
          ),
        ).thenThrow(Exception('boom'));

        final result =
            await repository.save(const SqlSuggestionSettingsEntity())
                as FailureResult<void>;

        expect(
          result.error.type,
          AppLocalizationsKey.failedToSaveSqlSuggestionsSettings,
        );
      },
    );
  });
}
