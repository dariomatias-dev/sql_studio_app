import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/create_database_usecase.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

void main() {
  test('forwards the model to the repository and returns its result', () async {
    final repository = _MockDatabaseRepository();
    final useCase = CreateDatabaseUseCase(repository);
    final model = DatabaseModel(label: 'Todo', name: 'todo');

    when(
      () => repository.create(model),
    ).thenAnswer((_) async => const SuccessResult(null));

    final result = await useCase(model);

    expect(result.isSuccess, isTrue);
    verify(() => repository.create(model)).called(1);
  });
}
