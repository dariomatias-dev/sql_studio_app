import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Replaces all stored advanced SQL suggestions with a new list.
class SaveAllSqlAdvancedSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const SaveAllSqlAdvancedSuggestionsUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case, clearing storage before writing [suggestions].
  Future<void> call(List<SqlAdvancedSuggestionModel> suggestions) async {
    await _repository.clear();
    await _repository.addAll(suggestions);
  }
}
