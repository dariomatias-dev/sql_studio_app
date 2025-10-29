import 'package:sql_studio/src/repositories/database_repository.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';

class DatabaseService {
  final DatabaseRepository<DatabaseModel> _repository;

  DatabaseService({DatabaseRepository<DatabaseModel>? repository})
    : _repository =
          repository ??
          DatabaseRepository<DatabaseModel>(tableName: 'databases');

  Future<void> create(DatabaseModel model) async {
    try {
      await _repository.insert(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DatabaseModel>> getAll() async {
    try {
      final results = await _repository.getAll(orderBy: 'name ASC');
      return results.map((map) => DatabaseModel.fromMap(map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<DatabaseModel?> getById(String id) async {
    try {
      final result = await _repository.getById(id);
      if (result != null) {
        return DatabaseModel.fromMap(result);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(DatabaseModel model) async {
    try {
      await _repository.update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(DatabaseModel model) async {
    try {
      await _repository.delete(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(DatabaseModel model) async {
    try {
      final updated = model.copyWith(
        isFavorite: !model.isFavorite,
        updatedAt: DateTime.now(),
      );

      await _repository.update(updated.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearAll() async {
    try {
      await _repository.clear();
    } catch (e) {
      rethrow;
    }
  }
}
