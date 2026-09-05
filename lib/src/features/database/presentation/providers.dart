import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';

import 'package:sql_studio/src/features/database/data/datasources/database_local_datasource.dart';
import 'package:sql_studio/src/features/database/data/repositories/database_repository_impl.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/create_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_database_by_name_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_databases_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/toggle_database_favorite_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_state.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_view_model.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/default_databases_state.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/default_databases_view_model.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart'
    show sqlExecutionServiceProvider;

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

/// Provides the [GetDatabasesUseCase].
final Provider<GetDatabasesUseCase> getDatabasesUseCaseProvider = Provider(
  (ref) => GetDatabasesUseCase(ref.watch(databaseRepositoryProvider)),
);

/// Provides the [CreateDatabaseUseCase].
final Provider<CreateDatabaseUseCase> createDatabaseUseCaseProvider = Provider(
  (ref) => CreateDatabaseUseCase(ref.watch(databaseRepositoryProvider)),
);

/// Provides the [GetDatabaseByNameUseCase].
final Provider<GetDatabaseByNameUseCase> getDatabaseByNameUseCaseProvider =
    Provider(
      (ref) => GetDatabaseByNameUseCase(ref.watch(databaseRepositoryProvider)),
    );

/// Provides the [DeleteDatabaseUseCase].
final Provider<DeleteDatabaseUseCase> deleteDatabaseUseCaseProvider = Provider(
  (ref) => DeleteDatabaseUseCase(
    ref.watch(databaseRepositoryProvider),
    ref.watch(sqlExecutionServiceProvider),
  ),
);

/// Provides the [ToggleDatabaseFavoriteUseCase].
final Provider<ToggleDatabaseFavoriteUseCase>
toggleDatabaseFavoriteUseCaseProvider = Provider(
  (ref) => ToggleDatabaseFavoriteUseCase(ref.watch(databaseRepositoryProvider)),
);

/// Exposes the [DatabaseListViewModel] and its [DatabaseListState].
final NotifierProvider<DatabaseListViewModel, DatabaseListState>
databaseListViewModelProvider = NotifierProvider(DatabaseListViewModel.new);

/// Exposes the [DefaultDatabasesViewModel] and its [DefaultDatabasesState].
final NotifierProvider<DefaultDatabasesViewModel, DefaultDatabasesState>
defaultDatabasesViewModelProvider = NotifierProvider(
  DefaultDatabasesViewModel.new,
);
