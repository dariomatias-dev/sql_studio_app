import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Loads all advanced SQL suggestions.
class LoadSqlAdvancedSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const LoadSqlAdvancedSuggestionsUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case.
  Future<Result<List<SqlAdvancedSuggestionModel>>> call() =>
      _repository.getAll();
}
