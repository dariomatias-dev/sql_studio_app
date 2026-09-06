import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';

import 'test_helpers/app_harness.dart';

/// Covers deleting a database and confirming both its file and its
/// record are gone.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('deleting a database removes its file and record', (
    tester,
  ) async {
    final container = await pumpApp(tester);

    await deleteDatabaseIfExists(container, 'scratch');

    var scaffoldState = tester.state<ScaffoldState>(
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
    await tester.enterText(dialogFields.first, 'Scratch');
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.create));
    await tester.pumpAndSettle();

    scaffoldState.closeDrawer();
    await tester.pumpAndSettle();

    container.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
        'scratch';
    container.read(sqlEditorViewModelProvider.notifier).controller.fullText =
        'CREATE TABLE notes (id INTEGER PRIMARY KEY)';
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(l10n.runQuery));
    await tester.pumpAndSettle();

    final dbFile = File(join(await getDatabasesPath(), 'scratch.db'));
    expect(dbFile.existsSync(), isTrue);

    scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold).first)
      ..openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.delete));
    await tester.pumpAndSettle();

    expect(find.text('Scratch'), findsNothing);
    expect(dbFile.existsSync(), isFalse);
  });
}
