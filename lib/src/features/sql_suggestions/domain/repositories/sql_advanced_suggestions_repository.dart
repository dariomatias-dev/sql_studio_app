import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';

/// Persists and retrieves the advanced SQL autocomplete suggestions.
///
/// Uses [SqlAdvancedSuggestionModel] directly as its data contract: the
/// model is a plain, framework-free value object, so splitting it into a
/// separate domain entity would only duplicate the same fields.
abstract interface class SqlAdvancedSuggestionsRepository {
  /// Fetches all suggestions ordered by their display order.
  Future<List<SqlAdvancedSuggestionModel>> getAll();

  /// Persists a new suggestion.
  Future<void> create(SqlAdvancedSuggestionModel model);

  /// Persists multiple suggestions at once.
  Future<void> addAll(List<SqlAdvancedSuggestionModel> models);

  /// Updates an existing suggestion.
  Future<void> update(SqlAdvancedSuggestionModel model);

  /// Updates multiple suggestions at once.
  Future<void> updateAll(List<SqlAdvancedSuggestionModel> models);

  /// Deletes the suggestion matching [id].
  Future<void> delete(String id);

  /// Removes all stored suggestions.
  Future<void> clear();
}
