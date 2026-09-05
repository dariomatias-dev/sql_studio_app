import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Executes raw SQL statements against a named SQLite database and
/// inspects its structure.
class SqlExecutionService {
  final _logger = Logger();
  final _databases = <String, Database>{};

  Future<Database> _openDatabase(String databaseName) async {
    final cached = _databases[databaseName];
    if (cached != null) return cached;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$databaseName.db');
    final db = await openDatabase(path);

    _databases[databaseName] = db;

    return db;
  }

  /// Closes and evicts the cached connection for [databaseName], if any.
  /// Call this before the underlying database file is deleted so a later
  /// reuse of the same name doesn't hand back a stale handle.
  Future<void> closeDatabase(String databaseName) async {
    final db = _databases.remove(databaseName);
    await db?.close();
  }

  /// Closes and evicts every cached connection. Call this when the
  /// service is disposed so no SQLite handle outlives it.
  Future<void> closeAll() async {
    final databases = _databases.values.toList();
    _databases.clear();

    for (final db in databases) {
      await db.close();
    }
  }

  /// Runs one or more semicolon-separated [sql] statements against
  /// [databaseName], returning the result of the last statement.
  Future<Result<DatabaseSuccess?>> execute({
    required String sql,
    required String? databaseName,
  }) async {
    if (databaseName == null || databaseName.isEmpty) {
      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.noDatabaseSelected),
      );
    }

    try {
      final db = await _openDatabase(databaseName);

      final statements = _splitStatements(sql);

      DatabaseSuccess? lastResult;

      for (final stmt in statements) {
        final upper = _stripLeadingComments(stmt).toUpperCase();

        if (upper.startsWith('SELECT') || upper.startsWith('WITH')) {
          final result = await db.rawQuery(stmt);

          lastResult = DatabaseSuccess(result: result);

          _logger.i('Executed SELECT on $databaseName: $stmt');
        } else if (upper.startsWith('DELETE')) {
          final count = await db.rawDelete(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.deleteSuccess,
            args: {'count': count},
          );

          _logger.i('Executed DELETE: $stmt');
        } else if (upper.startsWith('UPDATE')) {
          final count = await db.rawUpdate(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.updateSuccess,
            args: {'count': count},
          );

          _logger.i('Executed UPDATE: $stmt');
        } else if (upper.startsWith('INSERT')) {
          final id = await db.rawInsert(stmt);

          lastResult = DatabaseSuccess(
            type: AppLocalizationsKey.insertSuccess,
            args: {'id': id},
          );

          _logger.i('Executed INSERT: $stmt');
        } else {
          await db.execute(stmt);

          lastResult = const DatabaseSuccess(
            type: AppLocalizationsKey.statementSuccess,
          );

          _logger.i('Executed SQL: $stmt');
        }
      }

      return SuccessResult(lastResult);
    } on Exception catch (err, stackTrace) {
      _logger.e('Failed to execute SQL', error: err, stackTrace: stackTrace);

      return FailureResult(
        DatabaseFailure(AppLocalizationsKey.sqlExecutionError, {'error': err}),
      );
    }
  }

  /// Strips leading `--` line comments and `/* */` block comments so
  /// statement-type detection isn't fooled by a commented-out prefix.
  String _stripLeadingComments(String sql) {
    var result = sql.trimLeft();

    while (true) {
      if (result.startsWith('--')) {
        final newlineIndex = result.indexOf('\n');
        result = newlineIndex == -1
            ? ''
            : result.substring(newlineIndex + 1).trimLeft();
      } else if (result.startsWith('/*')) {
        final endIndex = result.indexOf('*/');
        result = endIndex == -1
            ? ''
            : result.substring(endIndex + 2).trimLeft();
      } else {
        break;
      }
    }

    return result;
  }

  /// Splits [sql] into individual statements on top-level `;`, ignoring
  /// semicolons inside string literals, `--`/`/* */` comments, or
  /// `BEGIN...END` trigger bodies.
  List<String> _splitStatements(String sql) {
    final statements = <String>[];
    final buffer = StringBuffer();
    final upperSql = sql.toUpperCase();

    String? quoteChar;
    var blockDepth = 0;
    var inLineComment = false;
    var inBlockComment = false;

    for (var i = 0; i < sql.length; i++) {
      final char = sql[i];

      if (inLineComment) {
        buffer.write(char);
        if (char == '\n') inLineComment = false;
        continue;
      }

      if (inBlockComment) {
        buffer.write(char);
        if (char == '/' && i > 0 && sql[i - 1] == '*') inBlockComment = false;
        continue;
      }

      if (quoteChar != null) {
        buffer.write(char);
        if (char == quoteChar) quoteChar = null;
        continue;
      }

      if (char == "'" || char == '"') {
        quoteChar = char;
        buffer.write(char);
        continue;
      }

      if (char == '-' && i + 1 < sql.length && sql[i + 1] == '-') {
        inLineComment = true;
        buffer.write(char);
        continue;
      }

      if (char == '/' && i + 1 < sql.length && sql[i + 1] == '*') {
        inBlockComment = true;
        buffer.write(char);
        continue;
      }

      if (_matchesKeyword(upperSql, i, 'BEGIN')) {
        blockDepth++;
      } else if (_matchesKeyword(upperSql, i, 'END')) {
        if (blockDepth > 0) blockDepth--;
      }

      if (char == ';' && blockDepth == 0) {
        final stmt = buffer.toString().trim();
        if (stmt.isNotEmpty) statements.add(stmt);
        buffer.clear();
        continue;
      }

      buffer.write(char);
    }

    final last = buffer.toString().trim();
    if (last.isNotEmpty) statements.add(last);

    return statements;
  }

  bool _matchesKeyword(String upperSql, int index, String keyword) {
    if (index + keyword.length > upperSql.length) return false;
    if (upperSql.substring(index, index + keyword.length) != keyword) {
      return false;
    }

    final before = index == 0 ? ' ' : upperSql[index - 1];
    final afterIndex = index + keyword.length;
    final after = afterIndex >= upperSql.length ? ' ' : upperSql[afterIndex];

    return !_isWordChar(before) && !_isWordChar(after);
  }

  bool _isWordChar(String char) => RegExp('[A-Za-z0-9_]').hasMatch(char);

  /// Quotes [identifier] as an SQLite double-quoted identifier, escaping
  /// embedded double quotes.
  String _quoteIdentifier(String identifier) =>
      '"${identifier.replaceAll('"', '""')}"';

  /// Returns the names of all user tables in [databaseName].
  Future<List<String>> getTables({required String databaseName}) async {
    final db = await _openDatabase(databaseName);
    final result = await db.rawQuery(
      'SELECT name FROM sqlite_master '
      "WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );

    return result.builder((row, index) => row['name']! as String);
  }

  /// Returns the column names of [tableName] in [databaseName].
  Future<List<String>> getTableColumns({
    required String databaseName,
    required String tableName,
  }) async {
    final db = await _openDatabase(databaseName);
    final result = await db.rawQuery(
      'PRAGMA table_info(${_quoteIdentifier(tableName)});',
    );

    return result.builder((col, index) => col['name']! as String);
  }

  /// Returns the full table/column/foreign-key structure of
  /// [databaseName].
  Future<List<TableInfoModel>> getDatabaseStructure({
    required String databaseName,
  }) async {
    final db = await _openDatabase(databaseName);

    final tableResult = await db.rawQuery(
      'SELECT name FROM sqlite_master '
      "WHERE type='table' AND name NOT LIKE 'sqlite_%' "
      "AND name != 'android_metadata';",
    );

    final tables = <TableInfoModel>[];

    for (final row in tableResult) {
      final name = row['name']! as String;
      final quotedName = _quoteIdentifier(name);
      final results = await Future.wait([
        db.rawQuery('PRAGMA table_info($quotedName);'),
        db.rawQuery('PRAGMA foreign_key_list($quotedName);'),
      ]);
      final columnsRaw = results[0];
      final fkRaw = results[1];

      final columns = columnsRaw.builder((col, index) {
        final fk = fkRaw.firstWhere(
          (f) => f['from'] == col['name'],
          orElse: () => {},
        );

        return ColumnInfoModel(
          name: col['name']! as String,
          type: col['type']! as String,
          foreignTable: fk['table'] as String?,
          foreignColumn: fk['to'] as String?,
        );
      });

      tables.add(TableInfoModel(name: name, columns: columns));
    }

    return tables;
  }
}
