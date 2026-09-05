import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/database/data/providers/database_data_providers.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_state.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_view_model.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/default_databases_state.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/default_databases_view_model.dart';

/// Provides the [DeleteDatabaseUseCase].
final Provider<DeleteDatabaseUseCase> deleteDatabaseUseCaseProvider = Provider(
  (ref) => DeleteDatabaseUseCase(
    ref.watch(databaseRepositoryProvider),
    ref.watch(sqlExecutionServiceProvider),
  ),
);

/// Exposes the [DatabaseListViewModel] and its [DatabaseListState].
final NotifierProvider<DatabaseListViewModel, DatabaseListState>
databaseListViewModelProvider = NotifierProvider(DatabaseListViewModel.new);

/// Exposes the [DefaultDatabasesViewModel] and its [DefaultDatabasesState].
final NotifierProvider<DefaultDatabasesViewModel, DefaultDatabasesState>
defaultDatabasesViewModelProvider = NotifierProvider(
  DefaultDatabasesViewModel.new,
);
