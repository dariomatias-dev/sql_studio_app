import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';

import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/core/sql/sql_statement_splitter.dart';

/// Seeds and upgrades the bundled default (sample) databases.
class DefaultDatabaseService {
  /// Creates the service backed by the shared [_sqlService], so cached
  /// connections stay in sync with the rest of the app, and [_prefs] to
  /// track the seeded schema version.
  DefaultDatabaseService(this._sqlService, this._prefs);

  final SqlExecutionService _sqlService;
  final SharedPreferencesService _prefs;

  static const _currentVersion = 1;

  /// Runs schema/seed scripts for every default database when the
  /// stored version differs from [_currentVersion].
  Future<Result<void>> init() async {
    final storedVersion = _prefs.getInt(
      SharedPreferencesKeys.defaultDatabaseVersionKey,
    );

    if (storedVersion == _currentVersion) {
      return const SuccessResult(null);
    }

    for (final dbModel in defaultDatabases) {
      final result = await execute(dbModel.name);

      if (result.isFailure) {
        return result;
      }
    }

    await _prefs.setInt(
      SharedPreferencesKeys.defaultDatabaseVersionKey,
      _currentVersion,
    );

    return const SuccessResult(null);
  }

  /// Loads and runs the schema and seed SQL scripts for [dbName].
  Future<Result<void>> execute(String dbName) async {
    final logger = Logger();

    try {
      final schemaPath = 'assets/sql/schemas/${dbName}_schema.sql';
      final seedPath = 'assets/sql/seeds/${dbName}_seed.sql';

      final schemaSql = await rootBundle.loadString(schemaPath);
      final seedSql = await rootBundle.loadString(seedPath);

      final allSqlCommands = <String>[
        ...splitSqlStatements(schemaSql),
        ...splitSqlStatements(seedSql),
      ];

      for (final sql in allSqlCommands) {
        await _sqlService.execute(sql: sql, databaseName: dbName);
      }

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      logger.e(
        'Error executing SQL for database "$dbName".',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.failedToExecuteSql, {
          'dbName': dbName,
          'error': err.toString(),
        }),
      );
    } finally {
      await _sqlService.closeDatabase(dbName);
    }
  }
}
