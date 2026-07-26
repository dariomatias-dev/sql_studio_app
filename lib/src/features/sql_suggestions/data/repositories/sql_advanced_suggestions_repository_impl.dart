import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// [SqlAdvancedSuggestionsRepository] backed by
/// [SqlAdvancedSuggestionsLocalDatasource].
class SqlAdvancedSuggestionsRepositoryImpl
    implements SqlAdvancedSuggestionsRepository {
  /// Creates the repository with its [_datasource].
  const SqlAdvancedSuggestionsRepositoryImpl(this._datasource);

  final SqlAdvancedSuggestionsLocalDatasource _datasource;

  @override
  Future<List<SqlAdvancedSuggestionModel>> getAll() async {
    final maps = await _datasource.getAll();

    if (maps.isEmpty) {
      final defaults = List<SqlAdvancedSuggestionModel>.from(
        defaultSqlAdvancedSuggestions,
      );

      await _datasource.insertAll(defaults.map((m) => m.toMap()).toList());

      return defaults;
    }

    return maps.map(SqlAdvancedSuggestionModel.fromMap).toList();
  }

  @override
  Future<void> create(SqlAdvancedSuggestionModel model) async {
    await _datasource.insert(model.toMap());
  }

  @override
  Future<void> addAll(List<SqlAdvancedSuggestionModel> models) async {
    if (models.isEmpty) return;

    await _datasource.insertAll(models.map((m) => m.toMap()).toList());
  }

  @override
  Future<void> update(SqlAdvancedSuggestionModel model) async {
    await _datasource.update(model.toMap());
  }

  @override
  Future<void> delete(String id) async {
    await _datasource.deleteById(id);
  }

  @override
  Future<void> clear() => _datasource.clear();
}
