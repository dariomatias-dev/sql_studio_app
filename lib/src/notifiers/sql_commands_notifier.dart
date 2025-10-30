import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/sql_execution_service.dart';

class SqlCommandsNotifier extends ChangeNotifier {
  final _sqlService = SqlExecutionService();

  String? activeDatabase;
  dynamic result;
  bool isLoading = false;
  String? error;
  String? lastQuery;

  Future<void> runQuery(String sql) async {
    if (activeDatabase == null || activeDatabase!.isEmpty) {
      error = 'No active database.';
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
        result = response.value;
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
      error = 'No active database.';
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

  void clearResult() {
    result = null;
    error = null;
    notifyListeners();
  }
}
