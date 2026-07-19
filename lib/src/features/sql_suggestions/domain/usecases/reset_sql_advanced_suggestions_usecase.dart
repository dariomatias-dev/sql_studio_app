import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Restores the default advanced SQL suggestions, overwriting stored ones.
class ResetSqlAdvancedSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const ResetSqlAdvancedSuggestionsUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case, returning the restored default suggestions.
  Future<List<SqlAdvancedSuggestionModel>> call() async {
    final defaults = List<SqlAdvancedSuggestionModel>.from(
      defaultSqlAdvancedSuggestions,
    );

    await _repository.clear();
    await _repository.addAll(defaults);

    return defaults;
  }
}
