import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Deletes an advanced SQL suggestion from storage.
class RemoveSqlAdvancedSuggestionUseCase {
  /// Creates the use case backed by [_repository].
  const RemoveSqlAdvancedSuggestionUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case for the suggestion identified by [id].
  Future<Result<void>> call(String id) => _repository.delete(id);
}
