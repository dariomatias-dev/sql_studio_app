import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/usecases/get_database_structure_usecase.dart';

class _MockDatabaseStructureRepository extends Mock
    implements DatabaseStructureRepository {}

void main() {
  test('forwards the database name and returns the fetched tables', () async {
    final repository = _MockDatabaseStructureRepository();
    final useCase = GetDatabaseStructureUseCase(repository);
    final tables = [
      TableInfoEntity(
        name: 'todo_list',
        columns: [ColumnInfoEntity(name: 'id', type: 'TEXT')],
      ),
    ];

    when(
      () => repository.getStructure('todo_list'),
    ).thenAnswer((_) async => SuccessResult(tables));

    final result = await useCase('todo_list');

    expect(result.isSuccess, isTrue);
    verify(() => repository.getStructure('todo_list')).called(1);
  });
}
