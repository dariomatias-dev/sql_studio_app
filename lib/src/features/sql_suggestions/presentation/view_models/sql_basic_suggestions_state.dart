/// Presentation state for the basic SQL suggestions list.
class SqlBasicSuggestionsState {
  /// Creates the state, defaulting to an empty, non-loading list.
  const SqlBasicSuggestionsState({
    this.suggestions = const <String>[],
    this.isLoading = false,
  });

  /// The currently known basic suggestions.
  final List<String> suggestions;

  /// Whether a suggestions operation is currently in progress.
  final bool isLoading;

  /// Returns a copy of this state with the given fields replaced.
  SqlBasicSuggestionsState copyWith({
    List<String>? suggestions,
    bool? isLoading,
  }) {
    return SqlBasicSuggestionsState(
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
