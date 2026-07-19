import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Persists changes to an existing advanced SQL suggestion.
class UpdateSqlAdvancedSuggestionUseCase {
  /// Creates the use case backed by [_repository].
  const UpdateSqlAdvancedSuggestionUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case.
  Future<void> call(SqlAdvancedSuggestionModel suggestion) =>
      _repository.update(suggestion);
}
