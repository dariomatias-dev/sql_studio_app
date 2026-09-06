import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_suggestion_settings_local_datasource.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

void main() {
  test('getters default to their documented values when unset', () async {
    final datasource = SqlSuggestionSettingsLocalDatasource(
      await fakeSharedPreferencesService(),
    );

    expect(datasource.getUseBasicSuggestions(), isTrue);
    expect(datasource.getUseAdvancedSuggestions(), isFalse);
    expect(datasource.getUseCharacterSuggestions(), isTrue);
  });

  test('getters read back what was persisted', () async {
    final datasource = SqlSuggestionSettingsLocalDatasource(
      await fakeSharedPreferencesService({
        SharedPreferencesKeys.useBasicSuggestionsKey: false,
        SharedPreferencesKeys.useAdvancedSuggestionsKey: true,
        SharedPreferencesKeys.useCharacterSuggestionsKey: false,
      }),
    );

    expect(datasource.getUseBasicSuggestions(), isFalse);
    expect(datasource.getUseAdvancedSuggestions(), isTrue);
    expect(datasource.getUseCharacterSuggestions(), isFalse);
  });

  test('save persists all three flags under their own keys', () async {
    final prefs = await fakeSharedPreferencesService();
    final datasource = SqlSuggestionSettingsLocalDatasource(prefs);

    await datasource.save(
      useBasic: false,
      useAdvanced: true,
      useCharacter: false,
    );

    expect(datasource.getUseBasicSuggestions(), isFalse);
    expect(datasource.getUseAdvancedSuggestions(), isTrue);
    expect(datasource.getUseCharacterSuggestions(), isFalse);
  });
}
