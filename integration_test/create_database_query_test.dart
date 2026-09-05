import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/features/database/data/providers/database_data_providers.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';
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

    // Idempotent against a leftover 'bookstore' from a prior run: a
    // real device's storage isn't wiped between runs the way a fresh
    // CI emulator's is. Drops both the metadata record and the
    // physical SQLite file directly, independent of each other.
    final existing = await container
        .read(databaseRepositoryProvider)
        .getByName('bookstore');
    await existing.fold(
      onSuccess: (model) async {
        if (model == null) return;

        await container.read(deleteDatabaseUseCaseProvider)(model);
      },
    );
    await deleteDatabase(join(await getDatabasesPath(), 'bookstore.db'));

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

    // Selects the created database as active directly through the view
    // model. The drawer's own tap-to-select sets the active database to
    // its display label rather than its file name, a pre-existing
    // mismatch unrelated to this suite.
    container.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
        'bookstore';
    await tester.pumpAndSettle();

    final editor = container.read(sqlEditorViewModelProvider.notifier);

    Future<void> run(String sql) async {
      // On a real device, `tester.enterText` opens a live platform IME
      // connection; CodeController's own diff-based `value` setter then
      // conflicts with it across repeated calls, corrupting the text.
      // `fullText` replaces cleanly without ever touching that
      // connection, the same way the app's own suggestion chips do.
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
