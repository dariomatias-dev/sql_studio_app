import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

/// Locale code to the `screenshots/` subfolder matching that locale's
/// README (`README.md`, `README.es.md`, `README.pt-BR.md`).
const _localeFolders = <String, String>{
  'en': 'en',
  'es': 'es',
  'pt': 'pt-BR',
};

/// Drives the app through its main screens in every supported locale,
/// taking a screenshot of each, so marketing assets (README, Play Store,
/// website) can be generated without manually navigating the app.
///
/// Run with:
///   flutter drive \
///     --driver=test_driver/integration_test.dart \
///     --target=integration_test/screenshot_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture marketing screenshots', (tester) async {
    final sharedPreferencesService = await SharedPreferencesService.create();

    await binding.convertFlutterSurfaceToImage();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesServiceProvider.overrideWithValue(
            sharedPreferencesService,
          ),
        ],
        child: const SqlStudioApp(),
      ),
    );

    // Splash entry animation + resource loading.
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final container = ProviderScope.containerOf(
      tester.element(find.byType(Scaffold).first),
    );

    // Always screenshot in light theme.
    await container
        .read(appThemeModeViewModelProvider.notifier)
        .changeThemeMode(ThemeMode.light);
    await tester.pumpAndSettle();

    // Create a database of the user's own, so the drawer's list isn't
    // empty in its screenshots.
    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();
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
    await tester.tap(find.byKey(const Key('rootNavBar_home')));
    await tester.pumpAndSettle();

    for (final entry in _localeFolders.entries) {
      await container
          .read(appLocalizationViewModelProvider.notifier)
          .changeLocale(entry.key);
      await tester.pumpAndSettle();

      await _captureScreens(tester, binding, entry.value);
    }
  });
}

Future<void> _captureScreens(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  String folder,
) async {
  Future<void> shoot(String name) async {
    await tester.pumpAndSettle();
    await binding.takeScreenshot('$folder/$name');
  }

  final context = tester.element(find.byType(Scaffold).first);
  final l10n = AppLocalizations.of(context);

  // Home (SQL editor).
  await shoot('01_home');

  // Databases tab.
  await tester.tap(find.byKey(const Key('rootNavBar_databases')));
  await tester.pumpAndSettle();
  await shoot('02_databases');

  // Open the first default database in the editor, so it shows up in
  // the drawer's database list.
  await tester.tap(find.byType(DatabaseCardWidget).first);
  await tester.pumpAndSettle();
  await shoot('03_editor');

  // Navigation drawer.
  final scaffoldState = tester.state<ScaffoldState>(
    find.byType(Scaffold).first,
  )..openDrawer();
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

  // Theme selector sheet.
  await tester.tap(find.text(l10n.theme));
  await tester.pumpAndSettle();
  await shoot('08_theme_selector');
  await tester.tapAt(const Offset(20, 20));
  await tester.pumpAndSettle();

  // SQL suggestions settings.
  await tester.tap(find.text(l10n.sqlSuggestions));
  await tester.pumpAndSettle();
  await shoot('09_sql_suggestions_settings');
  await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
  await tester.pumpAndSettle();

  // Workspace layout settings.
  await tester.tap(find.text(l10n.workspaceLayout));
  await tester.pumpAndSettle();
  await shoot('10_workspace_layout_settings');
  await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
  await tester.pumpAndSettle();

  // Back to Home.
  await tester.tap(find.byKey(const Key('rootNavBar_home')));
  await tester.pumpAndSettle();
}
