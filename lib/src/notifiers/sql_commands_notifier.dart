import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/database/default_database_service.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

class SqlCommandsNotifier extends ChangeNotifier {
  final _sqlService = SqlExecutionService();

  String? _activeDatabase;
  Result? result;
  bool isLoading = false;
  AppLocalizationsKey? error;
  Map<String, Object?>? errorArgs;
  String? lastQuery;
  bool isDefaultDatabase = false;

  String? get activeDatabase => _activeDatabase;

  set activeDatabase(String? value) {
    _activeDatabase = value;

    if (value != null) {
      SharedPreferencesService.setString(
        SharedPreferencesKeys.selectedDatabaseKey,
        value,
      );
    }

    _checkActiveDatabase();

    notifyListeners();
  }

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
    } catch (e) {
      error = AppLocalizationsKey.sqlExecutionError;
      errorArgs = {'dbName': tableName, 'error': e.toString()};

      notifyListeners();

      return <String>[];
    }
  }

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
