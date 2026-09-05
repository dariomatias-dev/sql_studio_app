import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/providers/sql_suggestions_data_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_state.dart';

/// Manages the persisted list of basic SQL autocomplete suggestions.
class SqlBasicSuggestionsViewModel extends Notifier<SqlBasicSuggestionsState> {
  late final SqlBasicSuggestionsRepository _repository;

  @override
  SqlBasicSuggestionsState build() {
    _repository = ref.read(sqlBasicSuggestionsRepositoryProvider);

    return const SqlBasicSuggestionsState();
  }

  /// Loads the basic suggestions from storage, falling back to defaults.
  Future<Result<void>> load() async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.load();

    state = state.copyWith(isLoading: false);

    return result.when(
      onSuccess: (suggestions) {
        state = state.copyWith(suggestions: suggestions);

        return const SuccessResult(null);
      },
      onFailure: FailureResult.new,
    );
  }

  /// Adds [suggestion] to the list if it isn't already present.
  Future<Result<void>> add(String suggestion) async {
    if (state.suggestions.contains(suggestion)) {
      return const SuccessResult(null);
    }

    return _persist([...state.suggestions, suggestion]);
  }

  /// Replaces all stored suggestions with [newSuggestions].
  Future<Result<void>> updateSuggestions(List<String> newSuggestions) {
    return _persist(newSuggestions);
  }

  /// Removes [suggestion] from the list.
  Future<Result<void>> remove(String suggestion) {
    return _persist(
      state.suggestions.where((s) => s != suggestion).toList(),
    );
  }

  /// Restores the default basic suggestions, overwriting stored ones.
  Future<Result<void>> resetSuggestions() {
    return _persist(List<String>.from(defaultSqlBasicSuggestions));
  }

  Future<Result<void>> _persist(List<String> suggestions) async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.save(suggestions);

    state = state.copyWith(
      isLoading: false,
      suggestions: result.isSuccess ? suggestions : state.suggestions,
    );

    return result;
  }
}
