import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/error/error_handlers.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/logging/logger_app_logger.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/screens/startup_failure/startup_failure_app.dart';
import 'package:sql_studio/src/core/services/local_state_service.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

/// Global container so utilities outside the widget tree (e.g. AppToast)
/// can read providers without threading a [WidgetRef] through every call.
/// Assigned in [startApp] once the [SharedPreferencesService] override is
/// ready. Mutable (not `final`) so tests can point it at a container of
/// their own.
late ProviderContainer appProviderContainer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = LoggerAppLogger();

  installErrorHandlers(logger);

  await startApp(logger);
}

/// Resolves the app's local state and runs the app, falling back to
/// [StartupFailureApp] when that state cannot be loaded.
Future<void> startApp(AppLogger logger) async {
  try {
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
  } on Object catch (err, stackTrace) {
    logger.error('Startup failed', error: err, stackTrace: stackTrace);

    runApp(
      StartupFailureApp(
        onRetry: () => startApp(logger),
        onClearAppData: () async {
          await LocalStateService(logger).clear();

          await startApp(logger);
        },
      ),
    );
  }
}
