import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/logging/logger_app_logger.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';

/// Shared [AppLogger] used across the app to record failures before
/// mapping them to a result.
final appLoggerProvider = Provider<AppLogger>((ref) => LoggerAppLogger());

/// Shared [DatabaseManager] instance for datasources that need direct
/// access to the app's local SQLite connection.
final databaseManagerProvider = Provider<DatabaseManager>(
  (ref) => DatabaseManager(),
);

/// Shared [SharedPreferencesService] instance, resolved during app
/// bootstrap in `main()`.
///
/// Must be overridden with a resolved instance before use — see
/// `main.dart` for the production override and
/// `test/test_helpers/shared_preferences_test_helper.dart` for tests.
final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((
  ref,
) {
  throw UnimplementedError(
    'sharedPreferencesServiceProvider must be overridden with a resolved '
    'SharedPreferencesService before use.',
  );
});

/// Shared [SqlExecutionService], closing every cached connection when the
/// container holding it is disposed.
final Provider<SqlExecutionService> sqlExecutionServiceProvider = Provider((
  ref,
) {
  final service = SqlExecutionService(ref.watch(appLoggerProvider));
  ref.onDispose(service.closeAll);

  return service;
});

/// Shared [DefaultDatabaseService], sharing its connection cache with
/// [sqlExecutionServiceProvider].
final Provider<DefaultDatabaseService> defaultDatabaseServiceProvider =
    Provider(
      (ref) => DefaultDatabaseService(
        ref.watch(sqlExecutionServiceProvider),
        ref.watch(sharedPreferencesServiceProvider),
        ref.watch(appLoggerProvider),
      ),
    );
