import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_nav_bar_widget.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('renders the three nav items with home selected by default', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(RootNavBarWidget(pageController: PageController())),
    );

    expect(find.byKey(const Key('rootNavBar_home')), findsOneWidget);
    expect(find.byKey(const Key('rootNavBar_databases')), findsOneWidget);
    expect(find.byKey(const Key('rootNavBar_settings')), findsOneWidget);
    expect(find.text('HOME'), findsOneWidget);
  });

  testWidgets('tapping an item updates the navigation index', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(
            body: RootNavBarWidget(pageController: PageController()),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();

    expect(container.read(navigationViewModelProvider), 1);
  });

  testWidgets('tapping an item unfocuses the currently focused field', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await tester.pumpWidget(
      wrap(
        Column(
          children: <Widget>[
            TextField(focusNode: focusNode),
            RootNavBarWidget(pageController: PageController()),
          ],
        ),
      ),
    );

    focusNode.requestFocus();
    await tester.pump();
    expect(focusNode.hasFocus, isTrue);

    await tester.tap(find.byKey(const Key('rootNavBar_settings')));
    await tester.pumpAndSettle();

    expect(focusNode.hasFocus, isFalse);
  });
}
