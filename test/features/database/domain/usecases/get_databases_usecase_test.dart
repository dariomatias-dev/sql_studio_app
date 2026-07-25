import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_databases_usecase.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

void main() {
  test('returns every database from the repository', () async {
    final repository = _MockDatabaseRepository();
    final useCase = GetDatabasesUseCase(repository);
    final model = DatabaseModel(label: 'Todo', name: 'todo');

    when(
      repository.getAll,
    ).thenAnswer((_) async => SuccessResult([model]));

    final result = await useCase() as SuccessResult<List<DatabaseModel>>;

    expect(result.value.single.name, 'todo');
  });
}
