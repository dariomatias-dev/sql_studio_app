import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Persists a new ordering for the advanced SQL suggestions.
class ReorderSqlAdvancedSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const ReorderSqlAdvancedSuggestionsUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case, persisting each suggestion in [newOrder] with its
  /// new index in a single batch, and returning the updated list.
  Future<List<SqlAdvancedSuggestionModel>> call(
    List<SqlAdvancedSuggestionModel> newOrder,
  ) async {
    if (newOrder.isEmpty) return const [];

    final updated = [
      for (var i = 0; i < newOrder.length; i++)
        newOrder[i].copyWith(orderIndex: i),
    ];

    await _repository.updateAll(updated);

    return updated;
  }
}
