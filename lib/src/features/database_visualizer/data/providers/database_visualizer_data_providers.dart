import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/database_visualizer/data/repositories/database_structure_repository_impl.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';

/// Provides the [DatabaseStructureRepository] implementation.
final Provider<DatabaseStructureRepository>
databaseStructureRepositoryProvider = Provider(
  (ref) => DatabaseStructureRepositoryImpl(
    ref.watch(sqlExecutionServiceProvider),
    ref.watch(appLoggerProvider),
  ),
);
