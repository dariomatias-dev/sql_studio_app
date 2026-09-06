import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/sql_editor/data/repositories/sql_commands_repository_impl.dart';

class _MockSqlExecutionService extends Mock implements SqlExecutionService {}

class _MockDefaultDatabaseService extends Mock
    implements DefaultDatabaseService {}

void main() {
  late _MockSqlExecutionService sqlService;
  late _MockDefaultDatabaseService defaultDatabaseService;
  late SqlCommandsRepositoryImpl repository;

  setUp(() {
    sqlService = _MockSqlExecutionService();
    defaultDatabaseService = _MockDefaultDatabaseService();
    repository = SqlCommandsRepositoryImpl(sqlService, defaultDatabaseService);
  });

  test('execute forwards to SqlExecutionService', () async {
    when(
      () => sqlService.execute(sql: 'SELECT 1', databaseName: 'todo'),
    ).thenAnswer((_) async => const SuccessResult(null));

    final result = await repository.execute(
      sql: 'SELECT 1',
      databaseName: 'todo',
    );

    expect(result, isA<SuccessResult<DatabaseSuccess?>>());
    verify(
      () => sqlService.execute(sql: 'SELECT 1', databaseName: 'todo'),
    ).called(1);
  });

  test('getTableColumns forwards to SqlExecutionService', () async {
    when(
      () => sqlService.getTableColumns(
        databaseName: 'todo',
        tableName: 'tasks',
      ),
    ).thenAnswer((_) async => ['id', 'title']);

    final columns = await repository.getTableColumns(
      databaseName: 'todo',
      tableName: 'tasks',
    );

    expect(columns, ['id', 'title']);
  });

  test('resetDefaultDatabase forwards to DefaultDatabaseService', () async {
    when(
      () => defaultDatabaseService.execute('todo'),
    ).thenAnswer((_) async => const SuccessResult(null));

    final result = await repository.resetDefaultDatabase('todo');

    expect(result, isA<SuccessResult<void>>());
    verify(() => defaultDatabaseService.execute('todo')).called(1);
  });
}
