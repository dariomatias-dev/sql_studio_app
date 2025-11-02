import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/database/database_screen.dart';
import 'package:sql_studio/src/screens/main/main_screen.dart';
import 'package:sql_studio/src/screens/not_found/not_found_screen.dart';
import 'package:sql_studio/src/screens/sql_command_settings/sql_command_settings_screen.dart';
import 'package:sql_studio/src/screens/splash/splash_screen.dart';
import 'package:sql_studio/src/screens/workspace_layout/workspace_layout_screen.dart';

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
      ],
    ),
    GoRoute(
      path: RouteNames.sqlCommandSettings,
      builder: (context, state) => const SqlCommandSettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.workspaceLayout,
      builder: (context, state) => const WorkspaceLayoutScreen(),
    ),
  ],
);
