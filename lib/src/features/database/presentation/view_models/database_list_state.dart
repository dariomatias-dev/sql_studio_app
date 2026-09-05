import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

/// Presentation state for the list of saved databases.
class DatabaseListState {
  /// Creates the state, defaulting to an empty, non-loading list.
  const DatabaseListState({
    this.databases = const <DatabaseEntity>[],
    this.isLoading = false,
    this.filter = '',
  });

  /// Every known database, unfiltered and in insertion order.
  final List<DatabaseEntity> databases;

  /// Whether the databases are currently being loaded.
  final bool isLoading;

  /// The current search filter.
  final String filter;

  /// The favorite databases matching [filter].
  List<DatabaseEntity> get favorites =>
      _matching.where((db) => db.isFavorite).toList(growable: false);

  /// The non-favorite databases matching [filter].
  List<DatabaseEntity> get others =>
      _matching.where((db) => !db.isFavorite).toList(growable: false);

  Iterable<DatabaseEntity> get _matching {
    if (filter.isEmpty) return databases;

    final lower = filter.toLowerCase();

    return databases.where((db) => db.name.toLowerCase().contains(lower));
  }

  /// Returns a copy of this state with the given fields replaced.
  DatabaseListState copyWith({
    List<DatabaseEntity>? databases,
    bool? isLoading,
    String? filter,
  }) {
    return DatabaseListState(
      databases: databases ?? this.databases,
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
    );
  }
}
