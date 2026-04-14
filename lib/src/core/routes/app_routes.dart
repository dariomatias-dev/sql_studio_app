import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_paths.dart';

class AppRoutes {
  static void goToSplash(BuildContext context) {
    context.go(RoutePaths.splash);
  }

  static void goToMain(BuildContext context) {
    context.go(RoutePaths.main);
  }

  static void goToDatabase(BuildContext context) {
    context.push(RoutePaths.databaseFull);
  }

  static void goToDatabaseVisualizer(
    BuildContext context, {
    required String dbName,
  }) {
    final uri = Uri(path: '/database-visualizer/$dbName');

    context.push(uri.toString());
  }

  static void goToSqlBasicSettings(BuildContext context) {
    context.push(RoutePaths.sqlBasicSuggestionSettings);
  }

  static void goToSqlAdvancedSettings(BuildContext context) {
    context.push(RoutePaths.sqlAdvancedSuggestionSettings);
  }

  static void goToSqlSuggestionSettings(BuildContext context) {
    context.push(RoutePaths.sqlSuggestionSettings);
  }

  static void goToWorkspaceLayoutSettings(BuildContext context) {
    context.push(RoutePaths.workspaceLayoutSettings);
  }
}
