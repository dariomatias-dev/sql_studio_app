import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

/// Drives the app through its main screens, taking a screenshot of each,
/// so marketing assets (README, Play Store, website) can be generated
/// without manually navigating the app.
///
/// Run with:
///   flutter drive \
///     --driver=test_driver/integration_test.dart \
///     --target=integration_test/screenshot_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture marketing screenshots', (tester) async {
    await SharedPreferencesService.init();

    await binding.convertFlutterSurfaceToImage();

    await tester.pumpWidget(const ProviderScope(child: SqlStudioApp()));

    // Splash entry animation + resource loading.
    await tester.pumpAndSettle(const Duration(seconds: 3));

    Future<void> shoot(String name) async {
      await tester.pumpAndSettle();
      await binding.takeScreenshot(name);
    }

    // Home (SQL editor).
    await shoot('01_home');

    final context = tester.element(find.byType(Scaffold).first);
    final l10n = AppLocalizations.of(context)!;

    // Databases tab.
    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();
    await shoot('02_databases');

    // Open the first default database in the editor, so it shows up in
    // the drawer's database list.
    await tester.tap(find.byType(DatabaseCardWidget).first);
    await tester.pumpAndSettle();
    await shoot('03_editor');

    // Create a database of the user's own, so the drawer's list isn't
    // empty in its screenshot.
    final scaffoldState = tester.state<ScaffoldState>(
      find.byType(Scaffold).first,
    )..openDrawer();
    await tester.pumpAndSettle();
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

    // Navigation drawer.
    scaffoldState.openDrawer();
    await shoot('04_drawer');
    scaffoldState.closeDrawer();
    await tester.pumpAndSettle();

    // Database structure visualizer, via the card's overflow menu.
    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.viewStructure));
    await tester.pumpAndSettle();
    await shoot('05_visualizer');

    // Back to root, then Settings tab.
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('rootNavBar_settings')));
    await tester.pumpAndSettle();
    await shoot('06_settings');

    // Language selector sheet.
    await tester.tap(find.text(l10n.language));
    await tester.pumpAndSettle();
    await shoot('07_language_selector');
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();

    // SQL suggestions settings.
    await tester.tap(find.text(l10n.sqlSuggestions));
    await tester.pumpAndSettle();
    await shoot('08_sql_suggestions_settings');
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    // Workspace layout settings.
    await tester.tap(find.text(l10n.workspaceLayout));
    await tester.pumpAndSettle();
    await shoot('09_workspace_layout_settings');
  });
}
