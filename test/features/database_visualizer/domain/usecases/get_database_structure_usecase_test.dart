import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/usecases/get_database_structure_usecase.dart';

void main() {
  test('forwards the database name and returns the fetched tables', () async {
    String? receivedName;
    final useCase = GetDatabaseStructureUseCase((databaseName) async {
      receivedName = databaseName;

      return [
        TableInfoModel(
          name: databaseName,
          columns: [ColumnInfoModel(name: 'id', type: 'TEXT')],
        ),
      ];
    });

    final tables = await useCase('todo_list');

    expect(receivedName, 'todo_list');
    expect(tables.single.name, 'todo_list');
  });
}
