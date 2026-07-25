import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/get_table_columns_usecase.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  test(
    'forwards the database and table names and returns the columns',
    () async {
      final repository = _MockSqlCommandsRepository();
      final useCase = GetTableColumnsUseCase(repository);

      when(
        () => repository.getTableColumns(
          databaseName: 'todo_list',
          tableName: 'tasks',
        ),
      ).thenAnswer((_) async => ['id', 'title']);

      final columns = await useCase(
        databaseName: 'todo_list',
        tableName: 'tasks',
      );

      expect(columns, ['id', 'title']);
    },
  );
}
