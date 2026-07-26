import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sql_studio/src/core/navigation/root_navigation.dart';
import 'package:sql_studio/src/core/routes/route_names.dart';
import 'package:sql_studio/src/core/routes/route_paths.dart';
import 'package:sql_studio/src/core/screens/about/about_screen.dart';
import 'package:sql_studio/src/core/screens/not_found/not_found_screen.dart';
import 'package:sql_studio/src/core/screens/splash/splash_screen.dart';
import 'package:sql_studio/src/features/database/presentation/screens/database_screen.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/screens/database_visualizer_screen.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/screens/sql_advanced_suggestion_settings_screen.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/screens/sql_basic_suggestion_settings_screen.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/screens/sql_suggestion_settings_screen.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/screens/workspace_layout_settings_screen.dart';

/// Builds a [CustomTransitionPage] with a lateral slide transition used
/// across the app's routes for a consistent feel: the incoming screen
/// slides in from the right while the outgoing one shifts slightly to the
/// left, mirroring a standard directional push navigation.
CustomTransitionPage<void> _buildPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final incoming = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final outgoing = CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(incoming),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-0.25, 0),
          ).animate(outgoing),
          child: child,
        ),
      );
    },
  );
}

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
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const DatabaseScreen(),
            ),
          ),
          GoRoute(
            name: RouteNames.databaseVisualizer,
            path: RoutePaths.databaseVisualizer,
            pageBuilder: (context, state) {
              final databaseName = state.pathParameters['dbName']!;

              return _buildPage(
                key: state.pageKey,
                child: DatabaseVisualizerScreen(databaseName: databaseName),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.sqlBasicSuggestionSettings,
        path: RoutePaths.sqlBasicSuggestionSettings,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const SqlBasicSuggestionsSettingsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.sqlAdvancedSuggestionSettings,
        path: RoutePaths.sqlAdvancedSuggestionSettings,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const SqlAdvancedSuggestionSettingsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.workspaceLayoutSettings,
        path: RoutePaths.workspaceLayoutSettings,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const WorkspaceLayoutSettingsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.sqlSuggestionSettings,
        path: RoutePaths.sqlSuggestionSettings,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const SqlSuggestionSettingsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.about,
        path: RoutePaths.about,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const AboutScreen(),
        ),
      ),
    ],
  );
}
