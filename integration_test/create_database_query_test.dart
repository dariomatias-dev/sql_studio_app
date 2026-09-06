import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';

import 'test_helpers/app_harness.dart';

/// Covers creating a database, then running CREATE TABLE, INSERT and
/// SELECT against it through the console, confirming the inserted row
/// comes back.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('creates a database and runs SQL against it', (tester) async {
    final container = await pumpApp(tester);

    await deleteDatabaseIfExists(container, 'bookstore');

    final scaffoldState = tester.state<ScaffoldState>(
      find.byType(Scaffold).first,
    )..openDrawer();
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    );

    await tester.tap(find.text(l10n.newDatabase));
    await tester.pumpAndSettle();

    final dialogFields = find.descendant(
      of: find.byType(CreateDatabaseDialogWidget),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(dialogFields.first, 'Bookstore');
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.create));
    await tester.pumpAndSettle();

    scaffoldState.closeDrawer();
    await tester.pumpAndSettle();

    container.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
        'bookstore';
    await tester.pumpAndSettle();

    final editor = container.read(sqlEditorViewModelProvider.notifier);

    Future<void> run(String sql) async {
      editor.controller.fullText = sql;
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(l10n.runQuery));
      await tester.pumpAndSettle();
    }

    await run('CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT)');
    await run("INSERT INTO books (title) VALUES ('Dune')");
    await run('SELECT * FROM books');

    expect(find.byType(StyledDataTableWidget), findsOneWidget);
    expect(find.text('Dune'), findsOneWidget);
  });
}
