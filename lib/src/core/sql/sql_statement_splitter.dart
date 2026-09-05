/// Splits [sql] into individual statements on top-level `;`, ignoring
/// semicolons inside string literals, `--`/`/* */` comments, or
/// `BEGIN...END` trigger bodies.
List<String> splitSqlStatements(String sql) {
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
