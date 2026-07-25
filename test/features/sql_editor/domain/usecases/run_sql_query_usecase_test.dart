import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/run_sql_query_usecase.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  test('forwards the sql and database name and returns the result', () async {
    final repository = _MockSqlCommandsRepository();
    final useCase = RunSqlQueryUseCase(repository);
    const success = DatabaseSuccess(
      result: [
        {'id': 1},
      ],
    );

    when(
      () => repository.execute(
        sql: 'SELECT * FROM tasks;',
        databaseName: 'todo_list',
      ),
    ).thenAnswer((_) async => const SuccessResult(success));

    final result =
        await useCase(sql: 'SELECT * FROM tasks;', databaseName: 'todo_list')
            as SuccessResult<DatabaseSuccess?>;

    expect(result.value, same(success));
  });
}
