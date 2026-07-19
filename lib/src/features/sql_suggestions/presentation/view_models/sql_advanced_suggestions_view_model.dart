import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
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
  late final Logger _logger;

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
    _logger = ref.read(loggerProvider);

    return const SqlAdvancedSuggestionsState();
  }

  /// Loads all advanced suggestions from storage.
  Future<Result<void>> load() async {
    state = state.copyWith(isLoading: true);

    try {
      final suggestions = await _loadSuggestions();

      state = state.copyWith(suggestions: suggestions);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to load advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToLoadAdvancedSuggestions),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Persists [suggestion] and adds it to the current list.
  Future<Result<void>> addSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      await _addSuggestion(suggestion);

      state = state.copyWith(suggestions: [...state.suggestions, suggestion]);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to add advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToAddAdvancedSuggestion),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Persists changes to [suggestion] and updates it in the current list.
  Future<Result<void>> updateSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      await _updateSuggestion(suggestion);

      final updated = [...state.suggestions];
      final index = updated.indexWhere((s) => s.id == suggestion.id);
      if (index != -1) updated[index] = suggestion;

      state = state.copyWith(suggestions: updated);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to update advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToUpdateAdvancedSuggestion),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Deletes the suggestion identified by [id] from storage and the list.
  Future<Result<void>> removeSuggestion(String id) async {
    state = state.copyWith(isLoading: true);

    try {
      await _removeSuggestion(id);

      state = state.copyWith(
        suggestions: state.suggestions.where((s) => s.id != id).toList(),
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to remove advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToRemoveAdvancedSuggestion),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Replaces all stored suggestions with [newSuggestions].
  Future<Result<void>> saveAllSuggestions(
    List<SqlAdvancedSuggestionModel> newSuggestions,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      await _saveAllSuggestions(newSuggestions);

      state = state.copyWith(suggestions: newSuggestions);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to save all advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveAllAdvancedSuggestions),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Persists a new ordering for the suggestions, given as [newOrder].
  Future<Result<void>> reorderSuggestions(
    List<SqlAdvancedSuggestionModel> newOrder,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      final updated = await _reorderSuggestions(newOrder);

      state = state.copyWith(suggestions: updated);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to reorder advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToReorderAdvancedSuggestions),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Restores the default advanced suggestions, overwriting stored ones.
  Future<Result<void>> resetSuggestions() async {
    state = state.copyWith(isLoading: true);

    try {
      final defaults = await _resetSuggestions();

      state = state.copyWith(suggestions: defaults);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to reset advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToResetAdvancedSuggestions),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
