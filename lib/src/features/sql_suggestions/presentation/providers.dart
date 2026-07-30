import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';

import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_basic_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_suggestion_settings_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_advanced_suggestions_repository_impl.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_basic_suggestions_repository_impl.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_suggestion_settings_repository_impl.dart';

import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/add_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_basic_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_suggestion_settings_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/remove_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reset_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_all_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_sql_basic_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_sql_suggestion_settings_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/update_sql_advanced_suggestion_usecase.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_view_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_view_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_suggestion_settings_view_model.dart';

// ── Settings (toggles) ─────────────────────────────────────────────────

/// Provides the raw suggestion-toggle preferences datasource.
final Provider<SqlSuggestionSettingsLocalDatasource>
sqlSuggestionSettingsLocalDatasourceProvider = Provider(
  (ref) => const SqlSuggestionSettingsLocalDatasource(),
);

/// Provides the [SqlSuggestionSettingsRepository] implementation.
final Provider<SqlSuggestionSettingsRepository>
sqlSuggestionSettingsRepositoryProvider = Provider(
  (ref) => SqlSuggestionSettingsRepositoryImpl(
    ref.watch(sqlSuggestionSettingsLocalDatasourceProvider),
    ref.watch(loggerProvider),
  ),
);

/// Provides the [LoadSqlSuggestionSettingsUseCase].
final Provider<LoadSqlSuggestionSettingsUseCase>
loadSqlSuggestionSettingsUseCaseProvider = Provider(
  (ref) => LoadSqlSuggestionSettingsUseCase(
    ref.watch(sqlSuggestionSettingsRepositoryProvider),
  ),
);

/// Provides the [SaveSqlSuggestionSettingsUseCase].
final Provider<SaveSqlSuggestionSettingsUseCase>
saveSqlSuggestionSettingsUseCaseProvider = Provider(
  (ref) => SaveSqlSuggestionSettingsUseCase(
    ref.watch(sqlSuggestionSettingsRepositoryProvider),
  ),
);

/// Exposes the [SqlSuggestionSettingsViewModel] and its
/// [SqlSuggestionSettingsEntity].
final NotifierProvider<
  SqlSuggestionSettingsViewModel,
  SqlSuggestionSettingsEntity
>
sqlSuggestionSettingsViewModelProvider = NotifierProvider(
  SqlSuggestionSettingsViewModel.new,
);

// ── Basic suggestions ───────────────────────────────────────────────────

/// Provides the raw basic suggestions datasource.
final Provider<SqlBasicSuggestionsLocalDatasource>
sqlBasicSuggestionsLocalDatasourceProvider = Provider(
  (ref) => const SqlBasicSuggestionsLocalDatasource(),
);

/// Provides the [SqlBasicSuggestionsRepository] implementation.
final Provider<SqlBasicSuggestionsRepository>
sqlBasicSuggestionsRepositoryProvider = Provider(
  (ref) => SqlBasicSuggestionsRepositoryImpl(
    ref.watch(sqlBasicSuggestionsLocalDatasourceProvider),
    ref.watch(loggerProvider),
  ),
);

/// Provides the [LoadSqlBasicSuggestionsUseCase].
final Provider<LoadSqlBasicSuggestionsUseCase>
loadSqlBasicSuggestionsUseCaseProvider = Provider(
  (ref) => LoadSqlBasicSuggestionsUseCase(
    ref.watch(sqlBasicSuggestionsRepositoryProvider),
  ),
);

/// Provides the [SaveSqlBasicSuggestionsUseCase].
final Provider<SaveSqlBasicSuggestionsUseCase>
saveSqlBasicSuggestionsUseCaseProvider = Provider(
  (ref) => SaveSqlBasicSuggestionsUseCase(
    ref.watch(sqlBasicSuggestionsRepositoryProvider),
  ),
);

/// Exposes the [SqlBasicSuggestionsViewModel] and its
/// [SqlBasicSuggestionsState].
final NotifierProvider<SqlBasicSuggestionsViewModel, SqlBasicSuggestionsState>
sqlBasicSuggestionsViewModelProvider = NotifierProvider(
  SqlBasicSuggestionsViewModel.new,
);

// ── Advanced suggestions ────────────────────────────────────────────────

/// Provides the raw advanced suggestions datasource.
final Provider<SqlAdvancedSuggestionsLocalDatasource>
sqlAdvancedSuggestionsLocalDatasourceProvider = Provider(
  (ref) => SqlAdvancedSuggestionsLocalDatasource(),
);

/// Provides the [SqlAdvancedSuggestionsRepository] implementation.
final Provider<SqlAdvancedSuggestionsRepository>
sqlAdvancedSuggestionsRepositoryProvider = Provider(
  (ref) => SqlAdvancedSuggestionsRepositoryImpl(
    ref.watch(sqlAdvancedSuggestionsLocalDatasourceProvider),
    ref.watch(loggerProvider),
  ),
);

/// Provides the [LoadSqlAdvancedSuggestionsUseCase].
final Provider<LoadSqlAdvancedSuggestionsUseCase>
loadSqlAdvancedSuggestionsUseCaseProvider = Provider(
  (ref) => LoadSqlAdvancedSuggestionsUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Provides the [AddSqlAdvancedSuggestionUseCase].
final Provider<AddSqlAdvancedSuggestionUseCase>
addSqlAdvancedSuggestionUseCaseProvider = Provider(
  (ref) => AddSqlAdvancedSuggestionUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Provides the [UpdateSqlAdvancedSuggestionUseCase].
final Provider<UpdateSqlAdvancedSuggestionUseCase>
updateSqlAdvancedSuggestionUseCaseProvider = Provider(
  (ref) => UpdateSqlAdvancedSuggestionUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Provides the [RemoveSqlAdvancedSuggestionUseCase].
final Provider<RemoveSqlAdvancedSuggestionUseCase>
removeSqlAdvancedSuggestionUseCaseProvider = Provider(
  (ref) => RemoveSqlAdvancedSuggestionUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Provides the [SaveAllSqlAdvancedSuggestionsUseCase].
final Provider<SaveAllSqlAdvancedSuggestionsUseCase>
saveAllSqlAdvancedSuggestionsUseCaseProvider = Provider(
  (ref) => SaveAllSqlAdvancedSuggestionsUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Provides the [ReorderSqlAdvancedSuggestionsUseCase].
final Provider<ReorderSqlAdvancedSuggestionsUseCase>
reorderSqlAdvancedSuggestionsUseCaseProvider = Provider(
  (ref) => ReorderSqlAdvancedSuggestionsUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Provides the [ResetSqlAdvancedSuggestionsUseCase].
final Provider<ResetSqlAdvancedSuggestionsUseCase>
resetSqlAdvancedSuggestionsUseCaseProvider = Provider(
  (ref) => ResetSqlAdvancedSuggestionsUseCase(
    ref.watch(sqlAdvancedSuggestionsRepositoryProvider),
  ),
);

/// Exposes the [SqlAdvancedSuggestionsViewModel] and its
/// [SqlAdvancedSuggestionsState].
final NotifierProvider<
  SqlAdvancedSuggestionsViewModel,
  SqlAdvancedSuggestionsState
>
sqlAdvancedSuggestionsViewModelProvider = NotifierProvider(
  SqlAdvancedSuggestionsViewModel.new,
);
