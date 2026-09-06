import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_basic_suggestions_local_datasource.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

void main() {
  test('getSuggestions returns an empty list when unset', () async {
    final datasource = SqlBasicSuggestionsLocalDatasource(
      await fakeSharedPreferencesService(),
    );

    expect(datasource.getSuggestions(), isEmpty);
  });

  test('setSuggestions persists the list under sqlCommandsKey', () async {
    final prefs = await fakeSharedPreferencesService();
    final datasource = SqlBasicSuggestionsLocalDatasource(prefs);

    await datasource.setSuggestions(['SELECT * FROM', 'INSERT INTO']);

    expect(datasource.getSuggestions(), ['SELECT * FROM', 'INSERT INTO']);
    expect(
      prefs.getStringList(SharedPreferencesKeys.sqlCommandsKey),
      ['SELECT * FROM', 'INSERT INTO'],
    );
  });
}
