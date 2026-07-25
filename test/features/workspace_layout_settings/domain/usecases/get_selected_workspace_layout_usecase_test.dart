import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/get_selected_workspace_layout_usecase.dart';

class _MockWorkspaceLayoutRepository extends Mock
    implements WorkspaceLayoutRepository {}

void main() {
  test('returns whatever layout the repository reports', () {
    final repository = _MockWorkspaceLayoutRepository();
    final useCase = GetSelectedWorkspaceLayoutUseCase(repository);

    when(
      repository.getSelectedLayout,
    ).thenReturn(WorkspaceLayoutType.tabs);

    expect(useCase(), WorkspaceLayoutType.tabs);
  });
}
