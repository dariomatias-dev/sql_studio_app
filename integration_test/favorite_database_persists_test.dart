import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_card_widget.dart';

import 'test_helpers/app_harness.dart';

/// Covers creating a database, favoriting it through the drawer, and
/// confirming both the moved section and the favorite flag survive what
/// simulates a restart.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> openDrawer(WidgetTester tester) async {
    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pumpAndSettle();
  }

  testWidgets('favoriting a database survives a restart', (tester) async {
    final container = await pumpApp(tester);

    await deleteDatabaseIfExists(container, 'personal');

    await openDrawer(tester);

    final l10n = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    );
    final favoritesHeader = l10n.favorites.toUpperCase();

    await tester.tap(find.text(l10n.newDatabase));
    await tester.pumpAndSettle();

    final dialogFields = find.descendant(
      of: find.byType(CreateDatabaseDialogWidget),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(dialogFields.first, 'Personal');
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.create));
    await tester.pumpAndSettle();

    await openDrawer(tester);

    final personalCard = find.ancestor(
      of: find.text('Personal'),
      matching: find.byType(RootDrawerDatabaseCardWidget),
    );

    expect(find.text(favoritesHeader), findsNothing);

    await tester.tap(
      find.descendant(
        of: personalCard,
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.favorite));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text(favoritesHeader), findsOneWidget);
    expect(find.text('Personal'), findsOneWidget);

    await pumpApp(tester);

    await openDrawer(tester);

    expect(find.text(favoritesHeader), findsOneWidget);
    expect(find.text('Personal'), findsOneWidget);
  });
}
