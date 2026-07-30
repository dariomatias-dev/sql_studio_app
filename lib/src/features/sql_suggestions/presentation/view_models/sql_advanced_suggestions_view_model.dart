import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/add_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/remove_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reset_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_all_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/update_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_state.dart';

/// Manages the persisted list of advanced SQL autocomplete suggestions.
class SqlAdvancedSuggestionsViewModel
    extends Notifier<SqlAdvancedSuggestionsState> {
  late final LoadSqlAdvancedSuggestionsUseCase _loadSuggestions;
  late final AddSqlAdvancedSuggestionUseCase _addSuggestion;
  late final UpdateSqlAdvancedSuggestionUseCase _updateSuggestion;
  late final RemoveSqlAdvancedSuggestionUseCase _removeSuggestion;
  late final SaveAllSqlAdvancedSuggestionsUseCase _saveAllSuggestions;
  late final ReorderSqlAdvancedSuggestionsUseCase _reorderSuggestions;
  late final ResetSqlAdvancedSuggestionsUseCase _resetSuggestions;

  @override
  SqlAdvancedSuggestionsState build() {
    _loadSuggestions = ref.read(loadSqlAdvancedSuggestionsUseCaseProvider);
    _addSuggestion = ref.read(addSqlAdvancedSuggestionUseCaseProvider);
    _updateSuggestion = ref.read(updateSqlAdvancedSuggestionUseCaseProvider);
    _removeSuggestion = ref.read(removeSqlAdvancedSuggestionUseCaseProvider);
    _saveAllSuggestions = ref.read(
      saveAllSqlAdvancedSuggestionsUseCaseProvider,
    );
    _reorderSuggestions = ref.read(
      reorderSqlAdvancedSuggestionsUseCaseProvider,
    );
    _resetSuggestions = ref.read(resetSqlAdvancedSuggestionsUseCaseProvider);

    return const SqlAdvancedSuggestionsState();
  }

  /// Loads all advanced suggestions from storage.
  Future<Result<void>> load() async {
    state = state.copyWith(isLoading: true);

    final result = await _loadSuggestions();

    state = state.copyWith(isLoading: false);

    if (result is SuccessResult<List<SqlAdvancedSuggestionModel>>) {
      state = state.copyWith(suggestions: result.value);

      return const SuccessResult(null);
    }

    return FailureResult(
      (result as FailureResult<List<SqlAdvancedSuggestionModel>>).error,
    );
  }

  /// Persists [suggestion] and adds it to the current list.
  Future<Result<void>> addSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    state = state.copyWith(isLoading: true);

    final result = await _addSuggestion(suggestion);

    state = state.copyWith(
      isLoading: false,
      suggestions: result.isSuccess
          ? [...state.suggestions, suggestion]
          : state.suggestions,
    );

    return result;
  }

  /// Persists changes to [suggestion] and updates it in the current list.
  Future<Result<void>> updateSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    state = state.copyWith(isLoading: true);

    final result = await _updateSuggestion(suggestion);

    if (result.isSuccess) {
      final updated = [...state.suggestions];
      final index = updated.indexWhere((s) => s.id == suggestion.id);
      if (index != -1) updated[index] = suggestion;

      state = state.copyWith(isLoading: false, suggestions: updated);
    } else {
      state = state.copyWith(isLoading: false);
    }

    return result;
  }

  /// Deletes the suggestion identified by [id] from storage and the list.
  Future<Result<void>> removeSuggestion(String id) async {
    state = state.copyWith(isLoading: true);

    final result = await _removeSuggestion(id);

    state = state.copyWith(
      isLoading: false,
      suggestions: result.isSuccess
          ? state.suggestions.where((s) => s.id != id).toList()
          : state.suggestions,
    );

    return result;
  }

  /// Replaces all stored suggestions with [newSuggestions].
  Future<Result<void>> saveAllSuggestions(
    List<SqlAdvancedSuggestionModel> newSuggestions,
  ) async {
    state = state.copyWith(isLoading: true);

    final result = await _saveAllSuggestions(newSuggestions);

    state = state.copyWith(
      isLoading: false,
      suggestions: result.isSuccess ? newSuggestions : state.suggestions,
    );

    return result;
  }

  /// Persists a new ordering for the suggestions, given as [newOrder].
  Future<Result<void>> reorderSuggestions(
    List<SqlAdvancedSuggestionModel> newOrder,
  ) async {
    state = state.copyWith(isLoading: true);

    final result = await _reorderSuggestions(newOrder);

    state = state.copyWith(isLoading: false);

    if (result is SuccessResult<List<SqlAdvancedSuggestionModel>>) {
      state = state.copyWith(suggestions: result.value);

      return const SuccessResult(null);
    }

    return FailureResult(
      (result as FailureResult<List<SqlAdvancedSuggestionModel>>).error,
    );
  }

  /// Restores the default advanced suggestions, overwriting stored ones.
  Future<Result<void>> resetSuggestions() async {
    state = state.copyWith(isLoading: true);

    final result = await _resetSuggestions();

    state = state.copyWith(isLoading: false);

    if (result is SuccessResult<List<SqlAdvancedSuggestionModel>>) {
      state = state.copyWith(suggestions: result.value);

      return const SuccessResult(null);
    }

    return FailureResult(
      (result as FailureResult<List<SqlAdvancedSuggestionModel>>).error,
    );
  }
}
