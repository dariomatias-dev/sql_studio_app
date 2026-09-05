import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/toggle_database_favorite_usecase.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

void main() {
  test('forwards the model to the repository and returns its result', () async {
    final repository = _MockDatabaseRepository();
    final useCase = ToggleDatabaseFavoriteUseCase(repository);
    final model = DatabaseEntity(label: 'Todo', name: 'todo');

    when(() => repository.toggleFavorite(model)).thenAnswer(
      (_) async => SuccessResult(model.copyWith(isFavorite: true)),
    );

    final result = await useCase(model);

    expect(result.isSuccess, isTrue);
    verify(() => repository.toggleFavorite(model)).called(1);
  });
}
