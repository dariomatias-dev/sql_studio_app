import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';

import 'test_helpers/app_harness.dart';

/// Regression guard for a version bump that used to re-seed every
/// default database on every mismatch (see the fix in
/// `default_database_service.dart`): editing a default database's data
/// must survive what simulates an app restart, a second launch reading
/// the same on-disk state through a brand new provider container.
///
/// Uses the to-do list database (the first, and only single-table,
/// entry in `defaultDatabases`), against its `tasks` table.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const table = 'tasks';

  Future<int> taskCount(
    WidgetTester tester,
    ProviderContainer container,
  ) async {
    final l10n = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    );

    container.read(sqlEditorViewModelProvider.notifier).controller.fullText =
        'SELECT COUNT(*) AS c FROM $table';
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(l10n.runQuery));
    await tester.pumpAndSettle();

    final dataTable = tester.widget<DataTable>(find.byType(DataTable));
    final cell = dataTable.rows.single.cells.single.child as Text;

    return int.parse(cell.data!);
  }

  Future<void> openToDoList(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DatabaseCardWidget).first);
    await tester.pumpAndSettle();
  }

  testWidgets('editing a default database survives a restart', (
    tester,
  ) async {
    var container = await pumpApp(tester);

    await openToDoList(tester);

    final originalCount = await taskCount(tester, container);
    expect(originalCount, greaterThan(0));

    final l10n = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    );

    container.read(sqlEditorViewModelProvider.notifier).controller.fullText =
        'DELETE FROM $table WHERE id = 1';
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(l10n.runQuery));
    await tester.pumpAndSettle();

    final afterDeleteCount = await taskCount(tester, container);
    expect(afterDeleteCount, originalCount - 1);

    container = await pumpApp(tester);

    await openToDoList(tester);

    final afterRestartCount = await taskCount(tester, container);
    expect(afterRestartCount, afterDeleteCount);
  });
}
