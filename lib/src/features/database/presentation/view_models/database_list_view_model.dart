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
        state = state.copyWith(databases: databases);

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
        state = state.copyWith(databases: [...state.databases, model]);

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
        state = state.copyWith(databases: _without(model));

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
        state = state.copyWith(databases: [..._without(model), updated]);

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
  }

  List<DatabaseEntity> _without(DatabaseEntity model) =>
      state.databases.where((db) => db.id != model.id).toList();
}
