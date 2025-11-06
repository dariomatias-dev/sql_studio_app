import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/repositories/database_repository.dart';

class SqlAdvancedSuggestionsService {
  static const _tableName = 'sql_advanced_suggestions';

  final _repository = DatabaseRepository<SqlAdvancedSuggestionModel>(
    tableName: _tableName,
  );

  Future<List<SqlAdvancedSuggestionModel>> getAll() async {
    final maps = await _repository.getAll(orderBy: 'label ASC');

    return maps.map(SqlAdvancedSuggestionModel.fromMap).toList();
  }

  Future<SqlAdvancedSuggestionModel?> getById(String id) async {
    final map = await _repository.getById(id);

    if (map == null) return null;

    return SqlAdvancedSuggestionModel.fromMap(map);
  }

  Future<bool> create(SqlAdvancedSuggestionModel model) async {
    final map = model.toMap();
    final id = await _repository.insert(map);

    return id > 0;
  }

  Future<bool> addAll(List<SqlAdvancedSuggestionModel> models) async {
    if (models.isEmpty) return false;

    final maps = models.map((m) => m.toMap()).toList();
    final results = await _repository.insertAll(maps);

    return results.isNotEmpty;
  }

  Future<bool> update(SqlAdvancedSuggestionModel model) async {
    final result = await _repository.update(model.toMap());

    return result > 0;
  }

  Future<bool> delete(String id) async {
    final result = await _repository.deleteById(id);

    return result > 0;
  }

  Future<void> clear() async {
    await _repository.clear();
  }
}
