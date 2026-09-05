import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_database_by_name_usecase.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

void main() {
  test('forwards the name to the repository and returns its result', () async {
    final repository = _MockDatabaseRepository();
    final useCase = GetDatabaseByNameUseCase(repository);
    final model = DatabaseEntity(label: 'Todo', name: 'todo');

    when(
      () => repository.getByName('todo'),
    ).thenAnswer((_) async => SuccessResult(model));

    final result = await useCase('todo');

    expect(result.isSuccess, isTrue);
    verify(() => repository.getByName('todo')).called(1);
  });
}
