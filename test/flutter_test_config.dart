import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/main.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

/// Gives every test file a default [appProviderContainer], so code paths
/// that read it directly (e.g. `AppToast.show`) work even in tests that
/// never build one of their own. Individual tests may still replace it.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  appProviderContainer = ProviderContainer(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(prefs),
      ),
    ],
  );

  await testMain();
}
