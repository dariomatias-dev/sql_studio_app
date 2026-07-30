/// Presentation state for the list of bundled default databases.
class DefaultDatabasesState {
  /// Creates the state, defaulting to no search filter applied.
  const DefaultDatabasesState({this.filter = ''});

  /// The current search filter, matched against each database's localized
  /// label.
  final String filter;

  /// Returns a copy of this state with the given fields replaced.
  DefaultDatabasesState copyWith({String? filter}) {
    return DefaultDatabasesState(filter: filter ?? this.filter);
  }
}
