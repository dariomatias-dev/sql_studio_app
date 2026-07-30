import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Replaces all stored advanced SQL suggestions with a new list.
class SaveAllSqlAdvancedSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const SaveAllSqlAdvancedSuggestionsUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case, clearing storage before writing [suggestions].
  Future<Result<void>> call(
    List<SqlAdvancedSuggestionModel> suggestions,
  ) async {
    final cleared = await _repository.clear();
    if (cleared.isFailure) return cleared;

    return _repository.addAll(suggestions);
  }
}
