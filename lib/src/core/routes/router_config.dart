import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/database/database_screen.dart';
import 'package:sql_studio/src/screens/database_visualizer/database_visualizer_screen.dart';
import 'package:sql_studio/src/screens/main/main_screen.dart';
import 'package:sql_studio/src/screens/not_found/not_found_screen.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_screen.dart';
import 'package:sql_studio/src/screens/splash/splash_screen.dart';
import 'package:sql_studio/src/screens/sql_suggestion_settings/sql_suggestion_settings_screen.dart';
import 'package:sql_studio/src/screens/workspace_layout_settings/workspace_layout_settings_screen.dart';

final router = GoRouter(
  initialLocation: RouteNames.splash,
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: <GoRoute>[
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.main,
      builder: (context, state) => const MainScreen(),
      routes: <GoRoute>[
        GoRoute(
          path: RouteNames.database,
          builder: (context, state) => const DatabaseScreen(),
        ),
        GoRoute(
          path: '${RouteNames.databaseVisualizerPath}:dbName',
          builder: (context, state) {
            final databaseName = state.pathParameters['dbName'] as String;

            return DatabaseVisualizerScreen(databaseName: databaseName);
          },
        ),
      ],
    ),
    GoRoute(
      path: RouteNames.sqlBasicSuggestionSettings,
      builder: (context, state) => const SqlBasicSuggestionsSettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.sqlAdvancedSuggestionSettings,
      builder: (context, state) => const SqlAdvancedSuggestionSettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.workspaceLayoutSettings,
      builder: (context, state) => const WorkspaceLayoutSettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.sqlSuggestionSettingsPath,
      builder: (context, state) => const SqlSuggestionSettingsScreen(),
    ),
  ],
);
