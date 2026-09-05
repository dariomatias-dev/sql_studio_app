import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/sql/sql_statement_splitter.dart';

void main() {
  test('splits on top-level semicolons and trims each statement', () {
    final statements = splitSqlStatements(
      'CREATE TABLE a (id INTEGER);\n  INSERT INTO a (id) VALUES (1);\n',
    );

    expect(statements, [
      'CREATE TABLE a (id INTEGER)',
      'INSERT INTO a (id) VALUES (1)',
    ]);
  });

  test('keeps a trailing statement without a semicolon', () {
    expect(splitSqlStatements('SELECT 1'), ['SELECT 1']);
  });

  test('drops empty statements', () {
    expect(splitSqlStatements(';;\n  ;'), isEmpty);
  });

  test('does not split on a semicolon inside a string literal', () {
    final statements = splitSqlStatements(
      "INSERT INTO a (t) VALUES ('one; two'); SELECT 1;",
    );

    expect(statements, [
      "INSERT INTO a (t) VALUES ('one; two')",
      'SELECT 1',
    ]);
  });

  test('does not split on a semicolon inside a double-quoted identifier', () {
    final statements = splitSqlStatements('SELECT "a;b" FROM t; SELECT 1;');

    expect(statements, ['SELECT "a;b" FROM t', 'SELECT 1']);
  });

  test('does not split on a semicolon inside a line comment', () {
    final statements = splitSqlStatements(
      '-- one; two\nSELECT 1;\nSELECT 2;',
    );

    expect(statements, ['-- one; two\nSELECT 1', 'SELECT 2']);
  });

  test('does not split on a semicolon inside a block comment', () {
    final statements = splitSqlStatements('/* one; two */ SELECT 1; SELECT 2;');

    expect(statements, ['/* one; two */ SELECT 1', 'SELECT 2']);
  });

  test('does not split inside a BEGIN...END trigger body', () {
    const sql = '''
CREATE TRIGGER t AFTER INSERT ON a
BEGIN
  UPDATE a SET id = 1;
  UPDATE a SET id = 2;
END;
SELECT 1;
''';

    final statements = splitSqlStatements(sql);

    expect(statements, hasLength(2));
    expect(statements.first, contains('UPDATE a SET id = 2;'));
    expect(statements.last, 'SELECT 1');
  });
}
