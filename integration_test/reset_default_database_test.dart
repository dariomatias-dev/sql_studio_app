import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';

import 'test_helpers/app_harness.dart';

/// Covers deliberately resetting a default database: after modifying
/// its data and resetting it back, it returns to the bundled seed.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const table = 'tasks';

  testWidgets('resetting a default database restores the bundled seed', (
    tester,
  ) async {
    final container = await pumpApp(tester);

    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DatabaseCardWidget).first);
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    );

    final editor = container.read(sqlEditorViewModelProvider.notifier);

    // `fullText` replaces the editor's content cleanly across repeated
    // calls; the plain `text` setter conflicts with a real device's
    // platform text input state and silently corrupts it.
    Future<void> run(String sql) async {
      editor.controller.fullText = sql;
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(l10n.runQuery));
      await tester.pumpAndSettle();
    }

    Future<int> taskCount() async {
      await run('SELECT COUNT(*) AS c FROM $table');

      final dataTable = tester.widget<DataTable>(find.byType(DataTable));
      final cell = dataTable.rows.single.cells.single.child as Text;

      return int.parse(cell.data!);
    }

    final originalCount = await taskCount();

    await run('DELETE FROM $table');
    expect(await taskCount(), 0);

    await tester.tap(find.byTooltip(l10n.options));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.resetDatabase));
    await tester.pumpAndSettle();

    expect(await taskCount(), originalCount);
  });
}
