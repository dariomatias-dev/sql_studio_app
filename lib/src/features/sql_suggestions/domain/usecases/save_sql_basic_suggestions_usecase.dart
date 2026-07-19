import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';

/// Persists the given list of basic SQL autocomplete suggestions.
class SaveSqlBasicSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const SaveSqlBasicSuggestionsUseCase(this._repository);

  final SqlBasicSuggestionsRepository _repository;

  /// Runs the use case.
  Future<Result<void>> call(List<String> suggestions) =>
      _repository.save(suggestions);
}
