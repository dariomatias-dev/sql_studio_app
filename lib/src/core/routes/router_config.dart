import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screen/main/main_screen.dart';
import 'package:sql_studio/src/screen/splash/splash_screen.dart';

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
    ),
  ],
);
