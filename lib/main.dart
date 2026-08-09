import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

/// Global container so utilities outside the widget tree (e.g. AppToast)
/// can read providers without threading a [WidgetRef] through every call.
/// Assigned in [main] once the [SharedPreferencesService] override is ready.
/// Mutable (not `final`) so tests can point it at a container of their own.
late ProviderContainer appProviderContainer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferencesService = await SharedPreferencesService.create();

  appProviderContainer = ProviderContainer(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        sharedPreferencesService,
      ),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: appProviderContainer,
      child: const SqlStudioApp(),
    ),
  );
}
