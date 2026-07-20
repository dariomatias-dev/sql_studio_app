import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';

/// Shared [Logger] instance used by data-layer repositories to record
/// failures before mapping them to a result.
final loggerProvider = Provider<Logger>((ref) => Logger());

/// Shared [DatabaseManager] instance for datasources that need direct
/// access to the app's local SQLite connection.
final databaseManagerProvider = Provider<DatabaseManager>(
  (ref) => DatabaseManager(),
);

/// Shared [SqlExecutionService] instance for running raw SQL against
/// user-created databases.
final sqlExecutionServiceProvider = Provider<SqlExecutionService>(
  (ref) => SqlExecutionService(),
);
