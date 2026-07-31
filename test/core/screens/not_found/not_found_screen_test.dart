import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/screens/not_found/not_found_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  GoRouter buildRouter() {
    return GoRouter(
      initialLocation: '/unknown-route',
      errorBuilder: (context, state) => const NotFoundScreen(),
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) =>
              const Scaffold(body: Text('Home Screen')),
        ),
      ],
    );
  }

  Widget wrap(GoRouter router) {
    return MaterialApp.router(
      theme: AppTheme.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    );
  }

  testWidgets('shows the not found message for an unresolved route', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(buildRouter()));
    await tester.pumpAndSettle();

    expect(find.text('Screen Not Found'), findsOneWidget);
    expect(
      find.text(
        'The screen you are looking for does not exist or has been moved.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('tapping "Go Home" navigates to the root route', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(buildRouter()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Go Home'));
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.byType(NotFoundScreen), findsNothing);
  });
}
