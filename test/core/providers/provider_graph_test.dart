import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/app_version/data/providers/app_version_data_providers.dart';
import 'package:sql_studio/src/features/app_version/presentation/app_version_providers.dart';
import 'package:sql_studio/src/features/database/data/providers/database_data_providers.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart'
    as domain;
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';
import 'package:sql_studio/src/features/database_visualizer/data/providers/database_visualizer_data_providers.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/repositories/database_structure_repository.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/database_visualizer_providers.dart';
import 'package:sql_studio/src/features/sql_editor/data/providers/sql_editor_data_providers.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/providers/sql_suggestions_data_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reset_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_all_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/data/providers/workspace_layout_data_providers.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/domain/repositories/workspace_layout_repository.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/workspace_layout_providers.dart';

import '../../test_helpers/shared_preferences_test_helper.dart';

/// Builds the production graph the way `startApp` does: every provider
/// resolved for real, with only `SharedPreferencesService` overridden, so
/// a miswired dependency fails here instead of on a device.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late ProviderContainer container;

  /// Every provider in `lib/`, by the name it is declared under, paired
  /// with how it is read and the type its value must have.
  Map<String, (Object? Function(ProviderContainer), Matcher)> graph() => {
    'appLoggerProvider': ((c) => c.read(appLoggerProvider), isA<AppLogger>()),
    'databaseManagerProvider': (
      (c) => c.read(databaseManagerProvider),
      isA<DatabaseManager>(),
    ),
    'sharedPreferencesServiceProvider': (
      (c) => c.read(sharedPreferencesServiceProvider),
      isNotNull,
    ),
    'sqlExecutionServiceProvider': (
      (c) => c.read(sqlExecutionServiceProvider),
      isA<SqlExecutionService>(),
    ),
    'defaultDatabaseServiceProvider': (
      (c) => c.read(defaultDatabaseServiceProvider),
      isA<DefaultDatabaseService>(),
    ),
    'appVersionLocalDatasourceProvider': (
      (c) => c.read(appVersionLocalDatasourceProvider),
      isNotNull,
    ),
    'appVersionRepositoryProvider': (
      (c) => c.read(appVersionRepositoryProvider),
      isNotNull,
    ),
    'databaseLocalDatasourceProvider': (
      (c) => c.read(databaseLocalDatasourceProvider),
      isNotNull,
    ),
    'databaseRepositoryProvider': (
      (c) => c.read(databaseRepositoryProvider),
      isA<domain.DatabaseRepository>(),
    ),
    'databaseStructureRepositoryProvider': (
      (c) => c.read(databaseStructureRepositoryProvider),
      isA<DatabaseStructureRepository>(),
    ),
    'sqlCommandsRepositoryProvider': (
      (c) => c.read(sqlCommandsRepositoryProvider),
      isA<SqlCommandsRepository>(),
    ),
    'sqlAdvancedSuggestionsLocalDatasourceProvider': (
      (c) => c.read(sqlAdvancedSuggestionsLocalDatasourceProvider),
      isNotNull,
    ),
    'sqlAdvancedSuggestionsRepositoryProvider': (
      (c) => c.read(sqlAdvancedSuggestionsRepositoryProvider),
      isA<SqlAdvancedSuggestionsRepository>(),
    ),
    'sqlBasicSuggestionsLocalDatasourceProvider': (
      (c) => c.read(sqlBasicSuggestionsLocalDatasourceProvider),
      isNotNull,
    ),
    'sqlBasicSuggestionsRepositoryProvider': (
      (c) => c.read(sqlBasicSuggestionsRepositoryProvider),
      isA<SqlBasicSuggestionsRepository>(),
    ),
    'sqlSuggestionSettingsLocalDatasourceProvider': (
      (c) => c.read(sqlSuggestionSettingsLocalDatasourceProvider),
      isNotNull,
    ),
    'sqlSuggestionSettingsRepositoryProvider': (
      (c) => c.read(sqlSuggestionSettingsRepositoryProvider),
      isA<SqlSuggestionSettingsRepository>(),
    ),
    'workspaceLayoutLocalDatasourceProvider': (
      (c) => c.read(workspaceLayoutLocalDatasourceProvider),
      isNotNull,
    ),
    'workspaceLayoutRepositoryProvider': (
      (c) => c.read(workspaceLayoutRepositoryProvider),
      isA<WorkspaceLayoutRepository>(),
    ),
    'deleteDatabaseUseCaseProvider': (
      (c) => c.read(deleteDatabaseUseCaseProvider),
      isA<DeleteDatabaseUseCase>(),
    ),
    'saveAllSqlAdvancedSuggestionsUseCaseProvider': (
      (c) => c.read(saveAllSqlAdvancedSuggestionsUseCaseProvider),
      isA<SaveAllSqlAdvancedSuggestionsUseCase>(),
    ),
    'reorderSqlAdvancedSuggestionsUseCaseProvider': (
      (c) => c.read(reorderSqlAdvancedSuggestionsUseCaseProvider),
      isA<ReorderSqlAdvancedSuggestionsUseCase>(),
    ),
    'resetSqlAdvancedSuggestionsUseCaseProvider': (
      (c) => c.read(resetSqlAdvancedSuggestionsUseCaseProvider),
      isA<ResetSqlAdvancedSuggestionsUseCase>(),
    ),
    'appLocalizationViewModelProvider': (
      (c) => c.read(appLocalizationViewModelProvider),
      isNotNull,
    ),
    'appThemeModeViewModelProvider': (
      (c) => c.read(appThemeModeViewModelProvider),
      isNotNull,
    ),
    'navigationViewModelProvider': (
      (c) => c.read(navigationViewModelProvider),
      isNotNull,
    ),
    'appVersionViewModelProvider': (
      (c) => c.read(appVersionViewModelProvider),
      isNotNull,
    ),
    'databaseListViewModelProvider': (
      (c) => c.read(databaseListViewModelProvider),
      isNotNull,
    ),
    'defaultDatabasesViewModelProvider': (
      (c) => c.read(defaultDatabasesViewModelProvider),
      isNotNull,
    ),
    'databaseVisualizerViewModelProvider': (
      (c) => c.read(databaseVisualizerViewModelProvider),
      isNotNull,
    ),
    'sqlCommandsViewModelProvider': (
      (c) => c.read(sqlCommandsViewModelProvider),
      isNotNull,
    ),
    'sqlEditorViewModelProvider': (
      (c) => c.read(sqlEditorViewModelProvider),
      isNotNull,
    ),
    'sqlAdvancedSuggestionsViewModelProvider': (
      (c) => c.read(sqlAdvancedSuggestionsViewModelProvider),
      isNotNull,
    ),
    'sqlBasicSuggestionsViewModelProvider': (
      (c) => c.read(sqlBasicSuggestionsViewModelProvider),
      isNotNull,
    ),
    'sqlSuggestionSettingsViewModelProvider': (
      (c) => c.read(sqlSuggestionSettingsViewModelProvider),
      isNotNull,
    ),
    'workspaceLayoutViewModelProvider': (
      (c) => c.read(workspaceLayoutViewModelProvider),
      isNotNull,
    ),
  };

  setUp(() async {
    container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          await fakeSharedPreferencesService(),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  test('every provider resolves to a value of the expected type', () {
    graph().forEach((name, entry) {
      final (read, matcher) = entry;

      expect(read(container), matcher, reason: name);
    });
  });

  test('reading a provider twice returns the same instance', () {
    expect(
      container.read(sqlExecutionServiceProvider),
      same(container.read(sqlExecutionServiceProvider)),
    );
    expect(
      container.read(databaseRepositoryProvider),
      same(container.read(databaseRepositoryProvider)),
    );
  });

  /// Fails when a provider is added to `lib/` without being wired into
  /// [graph], which is the only thing keeping this smoke test complete.
  test('covers every provider declared under lib/', () {
    final declared = <String>{};
    final pattern = RegExp(
      r'^final\s+(?:[\w<>,\s?]+\s+)?(\w+Provider)\s*=',
      multiLine: true,
    );

    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;

      for (final match in pattern.allMatches(entity.readAsStringSync())) {
        declared.add(match.group(1)!);
      }
    }

    expect(declared, isNotEmpty);
    expect(graph().keys.toSet(), declared);
  });
}
