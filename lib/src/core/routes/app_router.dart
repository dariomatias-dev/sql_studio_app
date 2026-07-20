import 'package:go_router/go_router.dart';
import 'package:sql_studio/src/core/navigation/root_navigation.dart';
import 'package:sql_studio/src/core/routes/route_names.dart';
import 'package:sql_studio/src/core/routes/route_paths.dart';
import 'package:sql_studio/src/core/views/not_found/not_found_screen.dart';
import 'package:sql_studio/src/core/views/splash/splash_screen.dart';
import 'package:sql_studio/src/features/database/presentation/views/database_screen.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/views/database_visualizer_screen.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/views/sql_advanced_suggestion_settings_screen.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/views/sql_basic_suggestion_settings_screen.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/views/sql_suggestion_settings_screen.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/views/workspace_layout_settings_screen.dart';

/// Configures and exposes the application's [GoRouter] instance.
class AppRouter {
  /// The [GoRouter] instance that defines all navigable routes of the app.
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
        name: RouteNames.root,
        path: RoutePaths.main,
        builder: (context, state) => const RootNavigation(),
        routes: <GoRoute>[
          GoRoute(
            name: RouteNames.database,
            path: RoutePaths.database,
            builder: (context, state) => const DatabaseScreen(),
          ),
          GoRoute(
            name: RouteNames.databaseVisualizer,
            path: RoutePaths.databaseVisualizer,
            builder: (context, state) {
              final databaseName = state.pathParameters['dbName']!;

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
        name: RouteNames.sqlSuggestionSettings,
        path: RoutePaths.sqlSuggestionSettings,
        builder: (context, state) => const SqlSuggestionSettingsScreen(),
      ),
    ],
  );
}
