import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_editor/data/repositories/sql_commands_repository_impl.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';

/// Provides the [SqlCommandsRepository] implementation.
final Provider<SqlCommandsRepository> sqlCommandsRepositoryProvider = Provider(
  (ref) => SqlCommandsRepositoryImpl(
    ref.watch(sqlExecutionServiceProvider),
    ref.watch(defaultDatabaseServiceProvider),
  ),
);
