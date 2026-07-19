import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_paths.dart';

/// Helper methods to navigate between the application's screens.
class AppRoutes {
  /// Navigates to the splash screen, replacing the current route.
  static void goToSplash(BuildContext context) {
    context.go(RoutePaths.splash);
  }

  /// Navigates to the main screen, replacing the current route.
  static void goToMain(BuildContext context) {
    context.go(RoutePaths.main);
  }

  /// Pushes the database screen onto the navigation stack.
  static void goToDatabase(BuildContext context) {
    unawaited(context.push(RoutePaths.database));
  }

  /// Pushes the database visualizer screen for the database named [dbName].
  static void goToDatabaseVisualizer(
    BuildContext context, {
    required String dbName,
  }) {
    final uri = Uri(path: '/database-visualizer/$dbName');

    unawaited(context.push(uri.toString()));
  }

  /// Pushes the SQL basic suggestion settings screen.
  static void goToSqlBasicSettings(BuildContext context) {
    unawaited(context.push(RoutePaths.sqlBasicSuggestionSettings));
  }

  /// Pushes the SQL advanced suggestion settings screen.
  static void goToSqlAdvancedSettings(BuildContext context) {
    unawaited(context.push(RoutePaths.sqlAdvancedSuggestionSettings));
  }

  /// Pushes the SQL suggestion settings screen.
  static void goToSqlSuggestionSettings(BuildContext context) {
    unawaited(context.push(RoutePaths.sqlSuggestionSettings));
  }

  /// Pushes the workspace layout settings screen.
  static void goToWorkspaceLayoutSettings(BuildContext context) {
    unawaited(context.push(RoutePaths.workspaceLayoutSettings));
  }
}
