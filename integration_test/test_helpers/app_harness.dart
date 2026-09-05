import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

/// Builds the real app under a fresh [ProviderContainer], backed by the
/// real, on-device `SharedPreferences` and SQLite storage (not fakes),
/// and settles the splash screen's entry animation and resource
/// loading.
///
/// Returns the container so a test can read providers directly. Two
/// calls to this in the same test, each rebuilding the widget tree,
/// simulate an app restart: each reads the same on-disk state through a
/// brand new container, the way a real process restart would.
Future<ProviderContainer> pumpApp(WidgetTester tester) async {
  final sharedPreferencesService = await SharedPreferencesService.create();

  late ProviderContainer container;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          sharedPreferencesService,
        ),
      ],
      child: Builder(
        builder: (context) {
          container = ProviderScope.containerOf(context);

          return const SqlStudioApp();
        },
      ),
    ),
  );

  // Splash entry animation + default database seeding.
  await tester.pumpAndSettle(const Duration(seconds: 5));

  return container;
}
