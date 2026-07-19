import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/database/default_database_service.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

/// Runs SQL commands against the active database and tracks their state.
class SqlCommandsNotifier extends ChangeNotifier {
  final _sqlService = SqlExecutionService();

  String? _activeDatabase;

  /// The outcome of the most recently executed query.
  Result<Object?>? result;

  /// Whether a query or reset operation is currently in progress.
  bool isLoading = false;

  /// The localization key describing the last error, if any.
  AppLocalizationsKey? error;

  /// Arguments to interpolate into the [error] localization message.
  Map<String, Object?>? errorArgs;

  /// The SQL text of the last query that was run.
  String? lastQuery;

  /// Whether the active database is one of the built-in default databases.
  bool isDefaultDatabase = false;

  /// The name of the database currently selected for query execution.
  String? get activeDatabase => _activeDatabase;

  /// Selects [value] as the active database and persists the choice.
  set activeDatabase(String? value) {
    _activeDatabase = value;

    if (value != null) {
      unawaited(
        SharedPreferencesService.setString(
          SharedPreferencesKeys.selectedDatabaseKey,
          value,
        ),
      );
    }

    unawaited(_checkActiveDatabase());

    notifyListeners();
  }

  /// Executes [sql] against the active database and stores the result.
  Future<void> runQuery(String sql) async {
    if (activeDatabase == null || activeDatabase!.isEmpty) {
      error = AppLocalizationsKey.noDatabaseSelected;
      errorArgs = null;

      notifyListeners();

      return;
    }

    lastQuery = sql;
    isLoading = true;
    error = null;
    errorArgs = null;

    notifyListeners();

    final response = await _sqlService.execute(
      sql: sql,
      databaseName: activeDatabase,
    );

    isLoading = false;

    await response.fold(
      onSuccess: (value) {
        result = response;
      },
      onFailure: (err) {
        error = err.type;
        errorArgs = err.args;

        result = null;
      },
    );

    notifyListeners();
  }

  /// Retrieves the column names of [tableName] in the active database.
  Future<List<String>> getTableColumns(String tableName) async {
    if (activeDatabase == null || activeDatabase!.isEmpty) {
      error = AppLocalizationsKey.noDatabaseSelected;
      errorArgs = null;

      notifyListeners();

      return <String>[];
    }

    try {
      final columns = await _sqlService.getTableColumns(
        databaseName: activeDatabase!,
        tableName: tableName,
      );
      return columns;
    } on Exception catch (e) {
      error = AppLocalizationsKey.sqlExecutionError;
      errorArgs = {'dbName': tableName, 'error': e.toString()};

      notifyListeners();

      return <String>[];
    }
  }

  /// Restores the active default database to its original state.
  Future<void> resetDatabase() async {
    if (!isDefaultDatabase || _activeDatabase == null) return;

    isLoading = true;
    error = null;
    errorArgs = null;
    notifyListeners();

    final executeResult = await DefaultDatabaseService.execute(
      _activeDatabase!,
    );

    await executeResult.fold(
      onSuccess: (_) {
        result = const SuccessResult(
          AppLocalizationsKey.databaseResetSuccessfully,
        );
        error = null;
        errorArgs = null;
      },
      onFailure: (failure) {
        result = null;
        if (failure is DatabaseFailure) {
          error = AppLocalizationsKey.sqlExecutionError;
          errorArgs = {'error': failure.type};
        } else if (failure is AppFailure) {
          error = AppLocalizationsKey.failedToLoadSqlFiles;
          errorArgs = {'error': failure.type};
        } else {
          error = AppLocalizationsKey.unknownError;
          errorArgs = null;
        }
      },
    );

    isLoading = false;

    notifyListeners();
  }

  /// Clears the stored query result and any pending error state.
  void clearResult() {
    result = null;
    error = null;
    errorArgs = null;

    notifyListeners();
  }

  Future<void> _checkActiveDatabase() async {
    final dbName = activeDatabase;
    isDefaultDatabase =
        dbName != null && defaultDatabases.any((db) => db.name == dbName);
  }
}
