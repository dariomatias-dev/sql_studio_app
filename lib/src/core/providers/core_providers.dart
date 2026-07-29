import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/database/database_repository.dart';

/// Shared [Logger] instance used by data-layer repositories to record
/// failures before mapping them to a result.
final loggerProvider = Provider<Logger>((ref) => Logger());

/// Shared [DatabaseManager] instance for datasources that need direct
/// access to the app's local SQLite connection.
final databaseManagerProvider = Provider<DatabaseManager>(
  (ref) => DatabaseManager(),
);
