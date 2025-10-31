import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/default_database/default_database_screen.dart';
import 'package:sql_studio/src/screens/main/main_screen.dart';
import 'package:sql_studio/src/screens/sql_command_settings/sql_command_settings_screen.dart';
import 'package:sql_studio/src/screens/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: RouteNames.splash,
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
          path: RouteNames.defaultDatabase,
          builder: (context, state) => const DefaultDatabaseScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RouteNames.sqlCommandSettings,
      builder: (context, state) => const SqlCommandSettingsScreen(),
    ),
  ],
);
