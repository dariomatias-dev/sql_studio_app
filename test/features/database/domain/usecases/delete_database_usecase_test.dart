import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

void main() {
  late _MockDatabaseRepository repository;
  late DeleteDatabaseUseCase useCase;
  late DatabaseModel model;

  setUp(() {
    repository = _MockDatabaseRepository();
    useCase = DeleteDatabaseUseCase(repository);
    model = DatabaseModel(label: 'To-do list', name: 'todo_list');
  });

  test(
    'drops the database file then deletes the record when the drop '
    'succeeds',
    () async {
      when(
        () => repository.dropDatabaseFile(model),
      ).thenAnswer((_) async => const SuccessResult(null));
      when(
        () => repository.delete(model),
      ).thenAnswer((_) async => const SuccessResult(null));

      final result = await useCase(model);

      expect(result.isSuccess, isTrue);
      verify(() => repository.dropDatabaseFile(model)).called(1);
      verify(() => repository.delete(model)).called(1);
    },
  );

  test(
    'does not delete the record when dropping the file fails, and '
    'surfaces the drop failure',
    () async {
      const dropFailure = FailureResult<void>(
        DatabaseFailure(AppLocalizationsKey.toDoListLabel),
      );

      when(
        () => repository.dropDatabaseFile(model),
      ).thenAnswer((_) async => dropFailure);

      final result = await useCase(model);

      expect(result, same(dropFailure));
      verify(() => repository.dropDatabaseFile(model)).called(1);
      verifyNever(() => repository.delete(model));
    },
  );
}
