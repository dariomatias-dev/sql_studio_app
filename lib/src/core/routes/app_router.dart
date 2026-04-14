import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';
import 'package:sql_studio/src/core/routes/route_paths.dart';

import 'package:sql_studio/src/screens/database/database_screen.dart';
import 'package:sql_studio/src/screens/database_visualizer/database_visualizer_screen.dart';
import 'package:sql_studio/src/screens/main/main_screen.dart';
import 'package:sql_studio/src/screens/not_found/not_found_screen.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart';
import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_screen.dart';
import 'package:sql_studio/src/screens/splash/splash_screen.dart';
import 'package:sql_studio/src/screens/sql_suggestion_settings/sql_suggestion_settings_screen.dart';
import 'package:sql_studio/src/screens/workspace_layout_settings/workspace_layout_settings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutePaths.splash,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: <GoRoute>[
      GoRoute(
        name: RouteNames.splash,
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteNames.main,
        path: RoutePaths.main,
        builder: (context, state) => const MainScreen(),
        routes: <GoRoute>[
          GoRoute(
            name: RouteNames.database,
            path: RoutePaths.database,
            builder: (context, state) => const DatabaseScreen(),
          ),
          GoRoute(
            name: RouteNames.databaseVisualizerPath,
            path: RoutePaths.databaseVisualizer,
            builder: (context, state) {
              final databaseName = state.pathParameters['dbName'] as String;

              return DatabaseVisualizerScreen(databaseName: databaseName);
            },
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.sqlBasicSuggestionSettings,
        path: RoutePaths.sqlBasicSuggestionSettings,
        builder: (context, state) => const SqlBasicSuggestionsSettingsScreen(),
      ),
      GoRoute(
        name: RouteNames.sqlAdvancedSuggestionSettings,
        path: RoutePaths.sqlAdvancedSuggestionSettings,
        builder: (context, state) =>
            const SqlAdvancedSuggestionSettingsScreen(),
      ),
      GoRoute(
        name: RouteNames.workspaceLayoutSettings,
        path: RoutePaths.workspaceLayoutSettings,
        builder: (context, state) => const WorkspaceLayoutSettingsScreen(),
      ),
      GoRoute(
        name: RouteNames.sqlSuggestionSettingsPath,
        path: RoutePaths.sqlSuggestionSettings,
        builder: (context, state) => const SqlSuggestionSettingsScreen(),
      ),
    ],
  );
}
