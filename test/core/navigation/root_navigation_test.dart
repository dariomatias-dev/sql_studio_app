import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/navigation/root_navigation.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

import '../../test_helpers/shared_preferences_test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesService prefs;

  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [sharedPreferencesServiceProvider.overrideWithValue(prefs)],
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: child,
      ),
    );
  }

  setUp(() async {
    prefs = await fakeSharedPreferencesService();
  });

  testWidgets('renders the home screen and nav bar on the initial index', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const RootNavigation()));
    await tester.pump();

    expect(find.byType(RootNavigation), findsOneWidget);
  });

  testWidgets('tapping a nav bar item switches the active page', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const RootNavigation()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('rootNavBar_settings')));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(RootNavigation)),
    );
    expect(container.read(navigationViewModelProvider), 2);
  });

  testWidgets('opening the drawer shows the empty databases state', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const RootNavigation()));
    await tester.pumpAndSettle();

    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('No databases yet'), findsOneWidget);
  });
}
