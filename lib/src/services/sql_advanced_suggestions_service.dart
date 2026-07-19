import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/repositories/database_repository.dart';

/// Manages CRUD operations for saved advanced SQL suggestions.
class SqlAdvancedSuggestionsService {
  static const _tableName = 'sql_advanced_suggestions';

  final _repository = DatabaseRepository<SqlAdvancedSuggestionModel>(
    tableName: _tableName,
  );

  /// Fetches all suggestions ordered by their display order.
  Future<List<SqlAdvancedSuggestionModel>> getAll() async {
    final maps = await _repository.getAll(orderBy: 'order_index ASC');

    return maps.map(SqlAdvancedSuggestionModel.fromMap).toList();
  }

  /// Fetches the suggestion matching [id], or `null` if not found.
  Future<SqlAdvancedSuggestionModel?> getById(String id) async {
    final map = await _repository.getById(id);

    if (map == null) return null;

    return SqlAdvancedSuggestionModel.fromMap(map);
  }

  /// Persists a new suggestion. Returns `true` on success.
  Future<bool> create(SqlAdvancedSuggestionModel model) async {
    final map = model.toMap();
    final id = await _repository.insert(map);

    return id > 0;
  }

  /// Persists multiple suggestions at once. Returns `true` if at
  /// least one was inserted.
  Future<bool> addAll(List<SqlAdvancedSuggestionModel> models) async {
    if (models.isEmpty) return false;

    final maps = models.map((m) => m.toMap()).toList();
    final results = await _repository.insertAll(maps);

    return results.isNotEmpty;
  }

  /// Updates an existing suggestion. Returns `true` on success.
  Future<bool> update(SqlAdvancedSuggestionModel model) async {
    final result = await _repository.update(model.toMap());

    return result > 0;
  }

  /// Deletes the suggestion matching [id]. Returns `true` on success.
  Future<bool> delete(String id) async {
    final result = await _repository.deleteById(id);

    return result > 0;
  }

  /// Removes all stored suggestions.
  Future<void> clear() async {
    await _repository.clear();
  }
}
