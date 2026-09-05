import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';

/// Presentation state for the advanced SQL suggestions list.
class SqlAdvancedSuggestionsState {
  /// Creates the state, defaulting to an empty, non-loading list.
  const SqlAdvancedSuggestionsState({
    this.suggestions = const <SqlAdvancedSuggestionEntity>[],
    this.isLoading = false,
  });

  /// The currently known advanced suggestions.
  final List<SqlAdvancedSuggestionEntity> suggestions;

  /// Whether a suggestions operation is currently in progress.
  final bool isLoading;

  /// Returns a copy of this state with the given fields replaced.
  SqlAdvancedSuggestionsState copyWith({
    List<SqlAdvancedSuggestionEntity>? suggestions,
    bool? isLoading,
  }) {
    return SqlAdvancedSuggestionsState(
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
