import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/providers/database_data_providers.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_state.dart';

/// Manages the list of known databases and their favorite state.
class DatabaseListViewModel extends Notifier<DatabaseListState> {
  late final DatabaseRepository _repository;
  late final DeleteDatabaseUseCase _deleteDatabase;

  var _favorites = <DatabaseEntity>[];
  var _others = <DatabaseEntity>[];

  @override
  DatabaseListState build() {
    _repository = ref.read(databaseRepositoryProvider);
    _deleteDatabase = ref.read(deleteDatabaseUseCaseProvider);

    return const DatabaseListState();
  }

  /// Loads all databases and splits them into favorites and others.
  Future<Result<void>> loadDatabases() async {
    if (state.isLoading) return const SuccessResult(null);

    state = state.copyWith(isLoading: true);

    final result = await _repository.getAll();

    state = state.copyWith(isLoading: false);

    return result.when(
      onSuccess: (databases) {
        _favorites = databases.where((db) => db.isFavorite).toList();
        _others = databases.where((db) => !db.isFavorite).toList();

        _applyFilter();

        return const SuccessResult(null);
      },
      onFailure: (error) => FailureResult(DatabaseFailure(error.type)),
    );
  }

  /// Creates a new database from [model] and adds it to the proper list.
  Future<Result<void>> create(DatabaseEntity model) async {
    final result = await _repository.create(model);

    return result.when(
      onSuccess: (_) {
        _addToProperList(model);

        _applyFilter();

        return const SuccessResult(null);
      },
      onFailure: (error) =>
          FailureResult(DatabaseFailure(error.type, error.args)),
    );
  }

  /// Retrieves a database by its [name], or `null` if none is found.
  Future<Result<DatabaseEntity?>> getByName(String name) async {
    final result = await _repository.getByName(name);

    return result.when(
      onSuccess: SuccessResult.new,
      onFailure: (error) => FailureResult(DatabaseFailure(error.type)),
    );
  }

  /// Drops the underlying table and deletes [model] from the lists.
  Future<Result<void>> delete(DatabaseEntity model) async {
    final result = await _deleteDatabase(model);

    return result.when(
      onSuccess: (_) {
        _removeFromLists(model);

        _applyFilter();

        return const SuccessResult(null);
      },
      onFailure: (error) =>
          FailureResult(DatabaseFailure(error.type, error.args)),
    );
  }

  /// Toggles the favorite state of [model] and moves it between lists.
  Future<Result<void>> toggleFavorite(DatabaseEntity model) async {
    final result = await _repository.toggleFavorite(model);

    return result.when(
      onSuccess: (updated) {
        _removeFromLists(model);

        _addToProperList(updated);

        _applyFilter();

        return const SuccessResult(null);
      },
      onFailure: (error) =>
          FailureResult(DatabaseFailure(error.type, error.args)),
    );
  }

  /// Updates the search filter applied to the databases lists.
  void setFilter(String value) {
    if (state.filter == value) return;

    state = state.copyWith(filter: value);

    _applyFilter();
  }

  void _addToProperList(DatabaseEntity model) {
    if (model.isFavorite) {
      _favorites = [..._favorites, model];
    } else {
      _others = [..._others, model];
    }
  }

  void _removeFromLists(DatabaseEntity model) {
    _favorites = _favorites.where((db) => db.id != model.id).toList();
    _others = _others.where((db) => db.id != model.id).toList();
  }

  void _applyFilter() {
    state = state.copyWith(
      favorites: _filtered(_favorites),
      others: _filtered(_others),
    );
  }

  List<DatabaseEntity> _filtered(List<DatabaseEntity> list) {
    if (state.filter.isEmpty) return List.unmodifiable(list);

    final lower = state.filter.toLowerCase();

    return list
        .where((db) => db.name.toLowerCase().contains(lower))
        .toList(growable: false);
  }
}
