import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/database/data/datasources/database_local_datasource.dart';
import 'package:sql_studio/src/features/database/data/repositories/database_repository_impl.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';

/// Provides the raw database datasource.
final Provider<DatabaseLocalDatasource> databaseLocalDatasourceProvider =
    Provider(
      (ref) => DatabaseLocalDatasource(ref.watch(databaseManagerProvider)),
    );

/// Provides the [DatabaseRepository] implementation.
final Provider<DatabaseRepository> databaseRepositoryProvider = Provider(
  (ref) => DatabaseRepositoryImpl(
    ref.watch(databaseLocalDatasourceProvider),
    ref.watch(appLoggerProvider),
  ),
);
