import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/datasources/workspace_layout_local_datasource.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/repositories/workspace_layout_repository_impl.dart';

class _MockDatasource extends Mock implements WorkspaceLayoutLocalDatasource {}

class _MockLogger extends Mock implements AppLogger {}

void main() {
  late _MockDatasource datasource;
  late WorkspaceLayoutRepositoryImpl repository;

  setUp(() {
    datasource = _MockDatasource();
    repository = WorkspaceLayoutRepositoryImpl(datasource, _MockLogger());
  });

  group('getSelectedLayout', () {
    test('returns tabs when the persisted name matches', () {
      when(() => datasource.getLayoutName()).thenReturn('tabs');

      expect(repository.getSelectedLayout(), WorkspaceLayoutType.tabs);
    });

    test('defaults to split for any other persisted value', () {
      when(() => datasource.getLayoutName()).thenReturn('');

      expect(repository.getSelectedLayout(), WorkspaceLayoutType.split);
    });

    test('defaults to split for an unrecognized persisted value', () {
      when(() => datasource.getLayoutName()).thenReturn('garbage');

      expect(repository.getSelectedLayout(), WorkspaceLayoutType.split);
    });
  });

  group('setLayout', () {
    test('persists the layout name on success', () async {
      when(
        () => datasource.setLayoutName(any()),
      ).thenAnswer((_) async {});

      final result = await repository.setLayout(WorkspaceLayoutType.tabs);

      expect(result.isSuccess, isTrue);
      verify(() => datasource.setLayoutName('tabs')).called(1);
    });

    test('fails with failedToSaveWorkspaceLayout when saving throws', () async {
      when(
        () => datasource.setLayoutName(any()),
      ).thenThrow(Exception('boom'));

      final result =
          await repository.setLayout(WorkspaceLayoutType.split)
              as FailureResult<void>;

      expect(
        result.error.type,
        AppLocalizationsKey.failedToSaveWorkspaceLayout,
      );
    });
  });
}
