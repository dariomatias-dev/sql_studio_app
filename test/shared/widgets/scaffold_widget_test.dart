import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp.router(
    theme: AppTheme.light,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    routerConfig: GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(path: '/', builder: (context, state) => child),
        GoRoute(
          path: '/next',
          builder: (context, state) => ScaffoldWidget(
            appBar: AppBar(title: const Text('Next')),
            body: const Text('Next body'),
          ),
        ),
      ],
    ),
  );

  group('ScaffoldWidget', () {
    testWidgets('renders the body and no app bar when none is given', (
      tester,
    ) async {
      await tester.pumpWidget(wrap(const ScaffoldWidget(body: Text('Body'))));

      expect(find.text('Body'), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('renders the app bar title when an appBar is given', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ScaffoldWidget(
            appBar: AppBar(title: const Text('Title')),
            body: const Text('Body'),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('hides the leading back button when showExitButton is '
        'false', (tester) async {
      await tester.pumpWidget(
        wrap(
          ScaffoldWidget(
            appBar: AppBar(title: const Text('Title')),
            showExitButton: false,
            body: const Text('Body'),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);
    });

    testWidgets('the back button pops the current route', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => context.push('/next'),
                child: const Text('Go'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      expect(find.text('Next body'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      expect(find.text('Next body'), findsNothing);
    });
  });
}
