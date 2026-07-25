import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/set_workspace_layout_usecase.dart';

class _MockWorkspaceLayoutRepository extends Mock
    implements WorkspaceLayoutRepository {}

void main() {
  test(
    'forwards the layout to the repository and returns its result',
    () async {
      final repository = _MockWorkspaceLayoutRepository();
      final useCase = SetWorkspaceLayoutUseCase(repository);

      when(
        () => repository.setLayout(WorkspaceLayoutType.tabs),
      ).thenAnswer((_) async => const SuccessResult(null));

      final result = await useCase(WorkspaceLayoutType.tabs);

      expect(result.isSuccess, isTrue);
      verify(() => repository.setLayout(WorkspaceLayoutType.tabs)).called(1);
    },
  );
}
