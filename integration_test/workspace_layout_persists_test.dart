import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/workspace_layout_providers.dart';

import 'test_helpers/app_harness.dart';

/// Covers changing the workspace layout and confirming it survives what
/// simulates a restart: a second launch reading the same persisted
/// SharedPreferences state through a brand new provider container.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('the selected workspace layout survives a restart', (
    tester,
  ) async {
    var container = await pumpApp(tester);

    expect(
      container.read(workspaceLayoutViewModelProvider),
      WorkspaceLayoutType.split,
    );

    await tester.tap(find.byKey(const Key('rootNavBar_settings')));
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    );

    await tester.tap(find.text(l10n.workspaceLayout));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.tabsLayout));
    await tester.pumpAndSettle();

    expect(
      container.read(workspaceLayoutViewModelProvider),
      WorkspaceLayoutType.tabs,
    );

    container = await pumpApp(tester);

    expect(
      container.read(workspaceLayoutViewModelProvider),
      WorkspaceLayoutType.tabs,
    );
  });
}
