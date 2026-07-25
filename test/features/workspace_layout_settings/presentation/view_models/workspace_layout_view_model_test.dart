import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/get_selected_workspace_layout_usecase.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/usecases/set_workspace_layout_usecase.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/providers.dart';

class _MockWorkspaceLayoutRepository extends Mock
    implements WorkspaceLayoutRepository {}

void main() {
  late _MockWorkspaceLayoutRepository repository;

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        getSelectedWorkspaceLayoutUseCaseProvider.overrideWithValue(
          GetSelectedWorkspaceLayoutUseCase(repository),
        ),
        setWorkspaceLayoutUseCaseProvider.overrideWithValue(
          SetWorkspaceLayoutUseCase(repository),
        ),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  setUpAll(() {
    registerFallbackValue(WorkspaceLayoutType.split);
  });

  setUp(() {
    repository = _MockWorkspaceLayoutRepository();
  });

  test('build initializes state from the persisted layout', () {
    when(
      () => repository.getSelectedLayout(),
    ).thenReturn(WorkspaceLayoutType.tabs);

    final container = buildContainer();

    expect(
      container.read(workspaceLayoutViewModelProvider),
      WorkspaceLayoutType.tabs,
    );
  });

  test('setLayout updates the state on success', () async {
    when(
      () => repository.getSelectedLayout(),
    ).thenReturn(WorkspaceLayoutType.split);
    when(
      () => repository.setLayout(any()),
    ).thenAnswer((_) async => const SuccessResult(null));

    final container = buildContainer();
    final notifier = container.read(workspaceLayoutViewModelProvider.notifier);

    final result = await notifier.setLayout(WorkspaceLayoutType.tabs);

    expect(result.isSuccess, isTrue);
    expect(
      container.read(workspaceLayoutViewModelProvider),
      WorkspaceLayoutType.tabs,
    );
  });

  test('setLayout leaves the state unchanged on failure', () async {
    when(
      () => repository.getSelectedLayout(),
    ).thenReturn(WorkspaceLayoutType.split);
    when(() => repository.setLayout(any())).thenAnswer(
      (_) async => const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveWorkspaceLayout),
      ),
    );

    final container = buildContainer();
    final notifier = container.read(workspaceLayoutViewModelProvider.notifier);

    final result = await notifier.setLayout(WorkspaceLayoutType.tabs);

    expect(result.isFailure, isTrue);
    expect(
      container.read(workspaceLayoutViewModelProvider),
      WorkspaceLayoutType.split,
    );
  });
}
