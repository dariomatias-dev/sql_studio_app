import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/datasources/workspace_layout_local_datasource.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

void main() {
  test('getLayoutName returns an empty string when unset', () async {
    final datasource = WorkspaceLayoutLocalDatasource(
      await fakeSharedPreferencesService(),
    );

    expect(datasource.getLayoutName(), isEmpty);
  });

  test('setLayoutName persists under workspaceLayoutKey', () async {
    final prefs = await fakeSharedPreferencesService();
    final datasource = WorkspaceLayoutLocalDatasource(prefs);

    await datasource.setLayoutName('tabs');

    expect(datasource.getLayoutName(), 'tabs');
    expect(
      prefs.getString(SharedPreferencesKeys.workspaceLayoutKey),
      'tabs',
    );
  });
}
