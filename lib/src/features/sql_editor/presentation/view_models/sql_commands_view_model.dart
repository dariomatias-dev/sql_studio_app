import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_state.dart';

/// Runs SQL commands against the active database and tracks their state.
class SqlCommandsViewModel extends Notifier<SqlCommandsState> {
  late final SqlCommandsRepository _repository;

  @override
  SqlCommandsState build() {
    _repository = ref.read(sqlCommandsRepositoryProvider);

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
        ref
            .read(sharedPreferencesServiceProvider)
            .setString(SharedPreferencesKeys.selectedDatabaseKey, value),
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

    final response = await _repository.execute(
      sql: sql,
      databaseName: databaseName,
    );

    response.when(
      onSuccess: (_) => state = state.copyWith(
        isLoading: false,
        result: response,
        clearError: true,
      ),
      onFailure: (error) => state = state.copyWith(
        isLoading: false,
        error: error.type,
        errorArgs: error.args,
        clearResult: true,
      ),
    );
  }

  /// Retrieves the column names of [tableName] in the active database.
  Future<List<String>> getTableColumns(String tableName) async {
    final databaseName = state.activeDatabase;

    if (databaseName == null || databaseName.isEmpty) {
      state = state.copyWith(error: AppLocalizationsKey.noDatabaseSelected);

      return <String>[];
    }

    try {
      return await _repository.getTableColumns(
        databaseName: databaseName,
        tableName: tableName,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        error: AppLocalizationsKey.sqlExecutionError,
        errorArgs: {'error': e.toString()},
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

    final result = await _repository.resetDefaultDatabase(databaseName);

    result.when(
      onSuccess: (_) => state = state.copyWith(
        isLoading: false,
        clearError: true,
        clearResult: true,
      ),
      onFailure: (failure) => state = state.copyWith(
        isLoading: false,
        error: failure is DatabaseFailure
            ? AppLocalizationsKey.sqlExecutionError
            : AppLocalizationsKey.failedToLoadSqlFiles,
        errorArgs: {'error': failure.type},
        clearResult: true,
      ),
    );

    return result;
  }

  /// Clears the stored query result and any pending error state.
  void clearResult() {
    state = state.copyWith(clearResult: true, clearError: true);
  }
}
