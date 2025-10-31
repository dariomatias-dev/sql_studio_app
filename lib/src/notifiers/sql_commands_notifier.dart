import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

class SqlCommandsNotifier extends ChangeNotifier {
  final _sqlService = SqlExecutionService();

  String? _activeDatabase;
  dynamic result;
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

  Future<void> resetDatabase() async {
    if (!isDefaultDatabase || _activeDatabase == null) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final tables = await _sqlService.getTables(
        databaseName: _activeDatabase!,
      );
      for (final table in tables) {
        await _sqlService.execute(
          sql: 'DROP TABLE IF EXISTS "$table";',
          databaseName: _activeDatabase,
        );
      }

      final schemaPath = 'assets/sql/schemas/${_activeDatabase!}_schema.sql';
      final seedPath = 'assets/sql/seeds/${_activeDatabase!}_seed.sql';

      final schemaSql = await rootBundle.loadString(schemaPath);
      final seedSql = await rootBundle.loadString(seedPath);

      final allSqlCommands = <String>[
        ...schemaSql.split(';'),
        ...seedSql.split(';'),
      ];

      for (final sql in allSqlCommands) {
        final trimmedSql = sql.trim();
        if (trimmedSql.isEmpty) continue;

        final response = await _sqlService.execute(
          sql: trimmedSql,
          databaseName: _activeDatabase!,
        );

        if (response is FailureResult) {
          error = response.error.message;
          break;
        }
      }

      if (error == null) result = 'Database reset successfully';
    } catch (e) {
      error = 'Failed to reset database: $e';
      result = null;
    }

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
