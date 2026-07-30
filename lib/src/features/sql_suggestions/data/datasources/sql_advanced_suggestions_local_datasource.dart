import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';

/// Reads and writes advanced SQL suggestions rows in sqflite.
class SqlAdvancedSuggestionsLocalDatasource {
  /// Creates the datasource, backed by [manager].
  SqlAdvancedSuggestionsLocalDatasource(DatabaseManager manager)
    : _repository = DatabaseRepository<SqlAdvancedSuggestionModel>(
        tableName: _tableName,
        manager: manager,
      );

  static const _tableName = 'sql_advanced_suggestions';

  final DatabaseRepository<SqlAdvancedSuggestionModel> _repository;

  /// Fetches all rows ordered by their display order.
  Future<List<Map<String, dynamic>>> getAll() {
    return _repository.getAll(orderBy: 'order_index ASC');
  }

  /// Inserts a single row.
  Future<int> insert(Map<String, dynamic> map) => _repository.insert(map);

  /// Inserts multiple rows at once.
  Future<List<Object?>> insertAll(List<Map<String, dynamic>> maps) {
    return _repository.insertAll(maps);
  }

  /// Updates an existing row.
  Future<int> update(Map<String, dynamic> map) => _repository.update(map);

  /// Updates multiple rows at once.
  Future<List<Object?>> updateAll(List<Map<String, dynamic>> maps) {
    return _repository.updateAll(maps);
  }

  /// Deletes the row matching [id].
  Future<int> deleteById(String id) => _repository.deleteById(id);

  /// Removes all rows.
  Future<void> clear() => _repository.clear();
}
