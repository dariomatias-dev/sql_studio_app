import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';

/// Restores the default advanced SQL suggestions, overwriting stored ones.
class ResetSqlAdvancedSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const ResetSqlAdvancedSuggestionsUseCase(this._repository);

  final SqlAdvancedSuggestionsRepository _repository;

  /// Runs the use case, returning the restored default suggestions.
  Future<Result<List<SqlAdvancedSuggestionEntity>>> call() async {
    final defaults = List<SqlAdvancedSuggestionEntity>.from(
      defaultSqlAdvancedSuggestions,
    );

    final cleared = await _repository.clear();
    if (cleared.isFailure) {
      return FailureResult((cleared as FailureResult).error);
    }

    final added = await _repository.addAll(defaults);
    if (added.isFailure) return FailureResult((added as FailureResult).error);

    return SuccessResult(defaults);
  }
}
