import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/reset_default_database_usecase.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  test(
    'forwards the database name and returns the repository result',
    () async {
      final repository = _MockSqlCommandsRepository();
      final useCase = ResetDefaultDatabaseUseCase(repository);

      when(
        () => repository.resetDefaultDatabase('todo_list'),
      ).thenAnswer((_) async => const SuccessResult(null));

      final result = await useCase('todo_list');

      expect(result.isSuccess, isTrue);
      verify(() => repository.resetDefaultDatabase('todo_list')).called(1);
    },
  );
}
