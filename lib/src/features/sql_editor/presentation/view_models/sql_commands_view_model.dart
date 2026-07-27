import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/get_table_columns_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/reset_default_database_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/run_sql_query_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_state.dart';

/// Runs SQL commands against the active database and tracks their state.
class SqlCommandsViewModel extends Notifier<SqlCommandsState> {
  late final RunSqlQueryUseCase _runQuery;
  late final GetTableColumnsUseCase _getTableColumns;
  late final ResetDefaultDatabaseUseCase _resetDefaultDatabase;

  @override
  SqlCommandsState build() {
    _runQuery = ref.read(runSqlQueryUseCaseProvider);
    _getTableColumns = ref.read(getTableColumnsUseCaseProvider);
    _resetDefaultDatabase = ref.read(resetDefaultDatabaseUseCaseProvider);

    return const SqlCommandsState();
  }

  /// The name of the database currently selected for query execution.
  String? get activeDatabase => state.activeDatabase;

  /// Selects [value] as the active database and persists the choice.
  set activeDatabase(String? value) {
    state =
        (value == null
                ? state.copyWith(clearActiveDatabase: true)
                : state.copyWith(activeDatabase: value))
            .copyWith(
              isDefaultDatabase:
                  value != null &&
                  defaultDatabases.any((db) => db.name == value),
            );

    if (value != null) {
      unawaited(
        SharedPreferencesService.setString(
          SharedPreferencesKeys.selectedDatabaseKey,
          value,
        ),
      );
    }
  }

  /// Executes [sql] against the active database and stores the result.
  Future<void> runQuery(String sql) async {
    final databaseName = state.activeDatabase;

    if (databaseName == null || databaseName.isEmpty) {
      state = state.copyWith(error: AppLocalizationsKey.noDatabaseSelected);

      return;
    }

    state = state.copyWith(
      lastQuery: sql,
      isLoading: true,
      clearError: true,
    );

    final response = await _runQuery(sql: sql, databaseName: databaseName);

    if (response is SuccessResult<DatabaseSuccess?>) {
      state = state.copyWith(
        isLoading: false,
        result: response,
        clearError: true,
      );
    } else if (response is FailureResult<DatabaseSuccess?>) {
      state = state.copyWith(
        isLoading: false,
        error: response.error.type,
        errorArgs: response.error.args,
        clearResult: true,
      );
    }
  }

  /// Retrieves the column names of [tableName] in the active database.
  Future<List<String>> getTableColumns(String tableName) async {
    final databaseName = state.activeDatabase;

    if (databaseName == null || databaseName.isEmpty) {
      state = state.copyWith(error: AppLocalizationsKey.noDatabaseSelected);

      return <String>[];
    }

    try {
      return await _getTableColumns(
        databaseName: databaseName,
        tableName: tableName,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        error: AppLocalizationsKey.sqlExecutionError,
        errorArgs: {'dbName': tableName, 'error': e.toString()},
      );

      return <String>[];
    }
  }

  /// Restores the active default database to its original state.
  Future<Result<void>> resetDatabase() async {
    final databaseName = state.activeDatabase;

    if (!state.isDefaultDatabase || databaseName == null) {
      return const FailureResult(
        AppFailure(AppLocalizationsKey.noDatabaseSelected),
      );
    }

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _resetDefaultDatabase(databaseName);

    if (result is SuccessResult<void>) {
      state = state.copyWith(
        isLoading: false,
        clearError: true,
        clearResult: true,
      );
    } else if (result is FailureResult<void>) {
      final failure = result.error;

      state = state.copyWith(
        isLoading: false,
        error: failure is DatabaseFailure
            ? AppLocalizationsKey.sqlExecutionError
            : AppLocalizationsKey.failedToLoadSqlFiles,
        errorArgs: {'error': failure.type},
        clearResult: true,
      );
    }

    return result;
  }

  /// Clears the stored query result and any pending error state.
  void clearResult() {
    state = state.copyWith(clearResult: true, clearError: true);
  }
}
