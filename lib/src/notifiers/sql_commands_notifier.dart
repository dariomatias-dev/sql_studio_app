import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/database/default_database_service.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

class SqlCommandsNotifier extends ChangeNotifier {
  final _sqlService = SqlExecutionService();

  String? _activeDatabase;
  Result? result;
  bool isLoading = false;
  String? error;
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
      error = 'No active database. Select a database.';
      notifyListeners();
      return;
    }

    lastQuery = sql;
    isLoading = true;
    error = null;
    notifyListeners();

    final response = await _sqlService.execute(
      sql: sql,
      databaseName: activeDatabase,
    );

    isLoading = false;

    switch (response) {
      case SuccessResult():
        result = response;
        break;
      case FailureResult():
        error = response.error.message;
        result = null;
        break;
    }

    notifyListeners();
  }

  Future<List<String>> getTableColumns(String tableName) async {
    if (activeDatabase == null || activeDatabase!.isEmpty) {
      error = 'No active database. Select a database.';
      notifyListeners();
      return [];
    }

    try {
      final columns = await _sqlService.getTableColumns(
        databaseName: activeDatabase!,
        tableName: tableName,
      );
      return columns;
    } catch (e) {
      error = 'Failed to fetch table columns: $e';
      notifyListeners();
      return [];
    }
  }

  Future<void> resetDatabase() async {
    if (!isDefaultDatabase || _activeDatabase == null) return;

    isLoading = true;
    error = null;
    notifyListeners();

    final executeResult = await DefaultDatabaseService.execute(
      _activeDatabase!,
    );

    await executeResult.fold(
      onSuccess: (_) {
        result = const SuccessResult('Database reset successfully');
        error = null;
      },
      onFailure: (failure) {
        result = null;
        error = failure.message;
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void clearResult() {
    result = null;
    error = null;
    notifyListeners();
  }

  Future<void> _checkActiveDatabase() async {
    final dbName = activeDatabase;
    if (dbName != null) {
      isDefaultDatabase = defaultDatabases.any((db) => db.name == dbName);
    } else {
      isDefaultDatabase = false;
    }
  }
}
