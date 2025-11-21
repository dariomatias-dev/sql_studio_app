import 'package:flutter/services.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';

import 'package:sql_studio/src/services/sql_execution_service.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';

class DefaultDatabaseInitializer {
  DefaultDatabaseInitializer._();

  static const _currentVersion = 1;

  static Future<void> init() async {
    final storedVersion = SharedPreferencesService.getInt(
      SharedPreferencesKeys.defaultDatabaseVersionKey,
    );

    if (storedVersion == _currentVersion) return;

    final sqlService = SqlExecutionService();

    for (final dbModel in defaultDatabases) {
      final dbName = dbModel.name;

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
    }

    await SharedPreferencesService.setInt(
      SharedPreferencesKeys.defaultDatabaseVersionKey,
      _currentVersion,
    );
  }
}
