import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/database/default_database_model.dart';
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

  /// Version the single legacy key stood for: every default database
  /// seeded at version 1.
  static const _legacySeededVersion = 1;

  /// Seeds each default database whose stored version differs from the
  /// version declared by its [DefaultDatabaseModel], leaving the others,
  /// and the user's edits to them, untouched.
  Future<Result<void>> init() async {
    await _migrateLegacyVersionKey();

    for (final dbModel in defaultDatabases) {
      final key = SharedPreferencesKeys.defaultDatabaseVersionKey(dbModel.name);

      if (_prefs.getIntOrNull(key) == dbModel.version) continue;

      final result = await execute(dbModel.name);

      if (result.isFailure) {
        return result;
      }

      await _prefs.setInt(key, dbModel.version);
    }

    return const SuccessResult(null);
  }

  /// Rewrites the pre-per-database version key as one key per database,
  /// so an existing install is not re-seeded on top of the user's edits.
  Future<void> _migrateLegacyVersionKey() async {
    final legacyVersion = _prefs.getIntOrNull(
      SharedPreferencesKeys.legacyDefaultDatabaseVersionKey,
    );

    if (legacyVersion != _legacySeededVersion) return;

    for (final dbModel in defaultDatabases) {
      await _prefs.setInt(
        SharedPreferencesKeys.defaultDatabaseVersionKey(dbModel.name),
        _legacySeededVersion,
      );
    }

    await _prefs.remove(SharedPreferencesKeys.legacyDefaultDatabaseVersionKey);
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
        final result = await _sqlService.execute(
          sql: sql,
          databaseName: dbName,
        );

        if (result case FailureResult(:final error)) {
          logger.e('Failed to seed database "$dbName": ${error.args['error']}');

          return FailureResult(
            DatabaseFailure(AppLocalizationsKey.failedToExecuteSql, {
              'dbName': dbName,
              'error': error.args['error']?.toString() ?? '',
            }),
          );
        }
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
