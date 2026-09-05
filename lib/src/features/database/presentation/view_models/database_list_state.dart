import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

/// Presentation state for the list of saved databases.
class DatabaseListState {
  /// Creates the state, defaulting to empty, non-loading lists.
  const DatabaseListState({
    this.favorites = const <DatabaseEntity>[],
    this.others = const <DatabaseEntity>[],
    this.isLoading = false,
    this.filter = '',
  });

  /// The favorite databases, already matching [filter].
  final List<DatabaseEntity> favorites;

  /// The non-favorite databases, already matching [filter].
  final List<DatabaseEntity> others;

  /// Whether the databases are currently being loaded.
  final bool isLoading;

  /// The current search filter.
  final String filter;

  /// Returns a copy of this state with the given fields replaced.
  DatabaseListState copyWith({
    List<DatabaseEntity>? favorites,
    List<DatabaseEntity>? others,
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
