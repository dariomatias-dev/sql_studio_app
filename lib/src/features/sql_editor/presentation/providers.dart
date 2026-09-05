import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/sql_editor/data/repositories/sql_commands_repository_impl.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/get_table_columns_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/reset_default_database_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/run_sql_query_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_state.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_view_model.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_editor_state.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_editor_view_model.dart';

/// Provides the raw SQL execution service.
final Provider<SqlExecutionService> sqlExecutionServiceProvider = Provider((
  ref,
) {
  final service = SqlExecutionService();
  ref.onDispose(service.closeAll);

  return service;
});

/// Provides the [DefaultDatabaseService], sharing its connection cache
/// with [sqlExecutionServiceProvider].
final Provider<DefaultDatabaseService> defaultDatabaseServiceProvider =
    Provider(
      (ref) => DefaultDatabaseService(
        ref.watch(sqlExecutionServiceProvider),
        ref.watch(sharedPreferencesServiceProvider),
      ),
    );

/// Provides the [SqlCommandsRepository] implementation.
final Provider<SqlCommandsRepository> sqlCommandsRepositoryProvider = Provider(
  (ref) => SqlCommandsRepositoryImpl(
    ref.watch(sqlExecutionServiceProvider),
    ref.watch(defaultDatabaseServiceProvider),
  ),
);

/// Provides the [RunSqlQueryUseCase].
final Provider<RunSqlQueryUseCase> runSqlQueryUseCaseProvider = Provider(
  (ref) => RunSqlQueryUseCase(ref.watch(sqlCommandsRepositoryProvider)),
);

/// Provides the [GetTableColumnsUseCase].
final Provider<GetTableColumnsUseCase> getTableColumnsUseCaseProvider =
    Provider(
      (ref) => GetTableColumnsUseCase(ref.watch(sqlCommandsRepositoryProvider)),
    );

/// Provides the [ResetDefaultDatabaseUseCase].
final Provider<ResetDefaultDatabaseUseCase>
resetDefaultDatabaseUseCaseProvider = Provider(
  (ref) =>
      ResetDefaultDatabaseUseCase(ref.watch(sqlCommandsRepositoryProvider)),
);

/// Exposes the [SqlCommandsViewModel] and its [SqlCommandsState].
final NotifierProvider<SqlCommandsViewModel, SqlCommandsState>
sqlCommandsViewModelProvider = NotifierProvider(SqlCommandsViewModel.new);

/// Exposes the [SqlEditorViewModel] and its [SqlEditorState].
final NotifierProvider<SqlEditorViewModel, SqlEditorState>
sqlEditorViewModelProvider = NotifierProvider(SqlEditorViewModel.new);
