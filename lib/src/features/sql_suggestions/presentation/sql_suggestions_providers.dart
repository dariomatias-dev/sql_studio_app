import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/providers/sql_suggestions_data_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reset_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_all_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_view_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_view_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_suggestion_settings_view_model.dart';

// ── Settings (toggles) ─────────────────────────────────────────────────

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

/// Exposes the [SqlBasicSuggestionsViewModel] and its
/// [SqlBasicSuggestionsState].
final NotifierProvider<SqlBasicSuggestionsViewModel, SqlBasicSuggestionsState>
sqlBasicSuggestionsViewModelProvider = NotifierProvider(
  SqlBasicSuggestionsViewModel.new,
);

// ── Advanced suggestions ────────────────────────────────────────────────

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
