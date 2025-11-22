import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/services/sql_execution_service.dart';

class DefaultDatabaseService {
  DefaultDatabaseService._();

  static const _currentVersion = 1;

  static Future<Result<void>> init() async {
    final storedVersion = SharedPreferencesService.getInt(
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

    await SharedPreferencesService.setInt(
      SharedPreferencesKeys.defaultDatabaseVersionKey,
      _currentVersion,
    );

    return const SuccessResult(null);
  }

  static Future<Result<void>> execute(String dbName) async {
    final sqlService = SqlExecutionService();
    final logger = Logger();

    try {
      final schemaPath = 'assets/sql/schemas/${dbName}_schema.sql';
      final seedPath = 'assets/sql/seeds/${dbName}_seed.sql';

      final schemaSql = await rootBundle.loadString(schemaPath);
      final seedSql = await rootBundle.loadString(seedPath);

      final allSqlCommands = <String>[
        ...schemaSql.split(';'),
        ...seedSql.split(';'),
      ];

      for (final sql in allSqlCommands) {
        final trimmedSql = sql.trim();

        if (trimmedSql.isEmpty) continue;

        await sqlService.execute(sql: trimmedSql, databaseName: dbName);
      }

      return const SuccessResult(null);
    } on FlutterError catch (err, stackTrace) {
      logger.e(
        'Error loading SQL files for database "$dbName".',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure('Failed to load SQL files: ${err.message}'),
      );
    } on Exception catch (err, stackTrace) {
      logger.e(
        'Error executing SQL for database "$dbName".',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure('Failed to execute SQL for "$dbName": $err'),
      );
    }
  }
}
