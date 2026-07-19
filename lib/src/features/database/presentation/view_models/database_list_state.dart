import 'package:sql_studio/src/features/database/data/models/database_model.dart';

/// Presentation state for the list of saved databases.
class DatabaseListState {
  /// Creates the state, defaulting to empty, non-loading lists.
  const DatabaseListState({
    this.favorites = const <DatabaseModel>[],
    this.others = const <DatabaseModel>[],
    this.isLoading = false,
    this.filter = '',
  });

  /// The favorite databases, already matching [filter].
  final List<DatabaseModel> favorites;

  /// The non-favorite databases, already matching [filter].
  final List<DatabaseModel> others;

  /// Whether the databases are currently being loaded.
  final bool isLoading;

  /// The current search filter.
  final String filter;

  /// Returns a copy of this state with the given fields replaced.
  DatabaseListState copyWith({
    List<DatabaseModel>? favorites,
    List<DatabaseModel>? others,
    bool? isLoading,
    String? filter,
  }) {
    return DatabaseListState(
      favorites: favorites ?? this.favorites,
      others: others ?? this.others,
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
    );
  }
}
