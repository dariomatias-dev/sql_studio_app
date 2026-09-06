import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';
import 'package:sql_studio/src/core/routes/route_paths.dart';

void main() {
  late BuildContext capturedContext;

  Widget screenAt(String label) => Scaffold(body: Center(child: Text(label)));

  Future<void> pumpRouter(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: RoutePaths.main,
      routes: [
        GoRoute(
          path: RoutePaths.splash,
          builder: (context, state) => screenAt('splash'),
        ),
        GoRoute(
          path: RoutePaths.main,
          builder: (context, state) {
            capturedContext = context;

            return screenAt('main');
          },
          routes: [
            GoRoute(
              path: 'database',
              builder: (context, state) => screenAt('database'),
            ),
            GoRoute(
              path: 'database-visualizer/:dbName',
              builder: (context, state) =>
                  screenAt('visualizer:${state.pathParameters['dbName']}'),
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.sqlBasicSuggestionSettings,
          builder: (context, state) => screenAt('basic-settings'),
        ),
        GoRoute(
          path: RoutePaths.sqlAdvancedSuggestionSettings,
          builder: (context, state) => screenAt('advanced-settings'),
        ),
        GoRoute(
          path: RoutePaths.sqlSuggestionSettings,
          builder: (context, state) => screenAt('suggestion-settings'),
        ),
        GoRoute(
          path: RoutePaths.workspaceLayoutSettings,
          builder: (context, state) => screenAt('layout-settings'),
        ),
        GoRoute(
          path: RoutePaths.about,
          builder: (context, state) => screenAt('about'),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
  }

  test('RoutePaths.databaseVisualizer carries a :dbName placeholder', () {
    expect(RoutePaths.databaseVisualizer, contains(':dbName'));
  });

  testWidgets('goToSplash replaces the current route', (tester) async {
    await pumpRouter(tester);

    AppRoutes.goToSplash(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('splash'), findsOneWidget);
    expect(find.text('main'), findsNothing);
  });

  testWidgets('goToMain replaces the current route', (tester) async {
    await pumpRouter(tester);

    AppRoutes.goToDatabase(capturedContext);
    await tester.pumpAndSettle();

    AppRoutes.goToMain(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('main'), findsOneWidget);
    expect(find.text('database'), findsNothing);
  });

  testWidgets('goToDatabase pushes the database route', (tester) async {
    await pumpRouter(tester);

    AppRoutes.goToDatabase(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('database'), findsOneWidget);
  });

  testWidgets(
    'goToDatabaseVisualizer pushes the route with the encoded name',
    (tester) async {
      await pumpRouter(tester);

      AppRoutes.goToDatabaseVisualizer(capturedContext, dbName: 'my db');
      await tester.pumpAndSettle();

      expect(find.text('visualizer:my db'), findsOneWidget);
    },
  );

  testWidgets('goToSqlBasicSettings pushes the basic settings route', (
    tester,
  ) async {
    await pumpRouter(tester);

    AppRoutes.goToSqlBasicSettings(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('basic-settings'), findsOneWidget);
  });

  testWidgets('goToSqlAdvancedSettings pushes the advanced settings route', (
    tester,
  ) async {
    await pumpRouter(tester);

    AppRoutes.goToSqlAdvancedSettings(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('advanced-settings'), findsOneWidget);
  });

  testWidgets(
    'goToSqlSuggestionSettings pushes the suggestion settings route',
    (tester) async {
      await pumpRouter(tester);

      AppRoutes.goToSqlSuggestionSettings(capturedContext);
      await tester.pumpAndSettle();

      expect(find.text('suggestion-settings'), findsOneWidget);
    },
  );

  testWidgets('goToWorkspaceLayoutSettings pushes the layout settings route', (
    tester,
  ) async {
    await pumpRouter(tester);

    AppRoutes.goToWorkspaceLayoutSettings(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('layout-settings'), findsOneWidget);
  });

  testWidgets('goToAbout pushes the about route', (tester) async {
    await pumpRouter(tester);

    AppRoutes.goToAbout(capturedContext);
    await tester.pumpAndSettle();

    expect(find.text('about'), findsOneWidget);
  });
}
