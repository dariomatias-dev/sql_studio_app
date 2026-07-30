import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/usecases/create_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_database_by_name_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_databases_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/toggle_database_favorite_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/providers.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_state.dart';

/// Manages the list of known databases and their favorite state.
class DatabaseListViewModel extends Notifier<DatabaseListState> {
  late final GetDatabasesUseCase _getDatabases;
  late final CreateDatabaseUseCase _createDatabase;
  late final GetDatabaseByNameUseCase _getDatabaseByName;
  late final DeleteDatabaseUseCase _deleteDatabase;
  late final ToggleDatabaseFavoriteUseCase _toggleFavorite;

  var _favorites = <DatabaseModel>[];
  var _others = <DatabaseModel>[];

  @override
  DatabaseListState build() {
    _getDatabases = ref.read(getDatabasesUseCaseProvider);
    _createDatabase = ref.read(createDatabaseUseCaseProvider);
    _getDatabaseByName = ref.read(getDatabaseByNameUseCaseProvider);
    _deleteDatabase = ref.read(deleteDatabaseUseCaseProvider);
    _toggleFavorite = ref.read(toggleDatabaseFavoriteUseCaseProvider);

    return const DatabaseListState();
  }

  /// Loads all databases and splits them into favorites and others.
  Future<Result<void>> loadDatabases() async {
    if (state.isLoading) return const SuccessResult(null);

    state = state.copyWith(isLoading: true);

    final result = await _getDatabases();

    state = state.copyWith(isLoading: false);

    if (result is SuccessResult<List<DatabaseModel>>) {
      _favorites = result.value.where((db) => db.isFavorite).toList();
      _others = result.value.where((db) => !db.isFavorite).toList();

      _applyFilter();

      return const SuccessResult(null);
    } else if (result is FailureResult<List<DatabaseModel>>) {
      return FailureResult(DatabaseFailure(result.error.type));
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Creates a new database from [model] and adds it to the proper list.
  Future<Result<void>> create(DatabaseModel model) async {
    final result = await _createDatabase(model);

    if (result is SuccessResult) {
      _addToProperList(model);

      _applyFilter();

      return const SuccessResult(null);
    } else if (result is FailureResult) {
      return FailureResult(
        DatabaseFailure(result.error.type, result.error.args),
      );
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Retrieves a database by its [name], or `null` if none is found.
  Future<Result<DatabaseModel?>> getByName(String name) async {
    final result = await _getDatabaseByName(name);

    if (result is SuccessResult<DatabaseModel?>) {
      return SuccessResult(result.value);
    } else if (result is FailureResult<DatabaseModel?>) {
      return FailureResult(DatabaseFailure(result.error.type));
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Drops the underlying table and deletes [model] from the lists.
  Future<Result<void>> delete(DatabaseModel model) async {
    final result = await _deleteDatabase(model);

    if (result is SuccessResult) {
      _removeFromLists(model);

      _applyFilter();

      return const SuccessResult(null);
    } else if (result is FailureResult) {
      return FailureResult(
        DatabaseFailure(result.error.type, result.error.args),
      );
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Toggles the favorite state of [model] and moves it between lists.
  Future<Result<void>> toggleFavorite(DatabaseModel model) async {
    final result = await _toggleFavorite(model);

    if (result is SuccessResult<DatabaseModel>) {
      _removeFromLists(model);

      _addToProperList(result.value);

      _applyFilter();

      return const SuccessResult(null);
    } else if (result is FailureResult<DatabaseModel>) {
      return FailureResult(
        DatabaseFailure(result.error.type, result.error.args),
      );
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Updates the search filter applied to the databases lists.
  void setFilter(String value) {
    if (state.filter == value) return;

    state = state.copyWith(filter: value);

    _applyFilter();
  }

  void _addToProperList(DatabaseModel model) {
    if (model.isFavorite) {
      _favorites = [..._favorites, model];
    } else {
      _others = [..._others, model];
    }
  }

  void _removeFromLists(DatabaseModel model) {
    _favorites = _favorites.where((db) => db.id != model.id).toList();
    _others = _others.where((db) => db.id != model.id).toList();
  }

  void _applyFilter() {
    state = state.copyWith(
      favorites: _filtered(_favorites),
      others: _filtered(_others),
    );
  }

  List<DatabaseModel> _filtered(List<DatabaseModel> list) {
    if (state.filter.isEmpty) return List.unmodifiable(list);

    final lower = state.filter.toLowerCase();

    return list
        .where((db) => db.name.toLowerCase().contains(lower))
        .toList(growable: false);
  }
}
