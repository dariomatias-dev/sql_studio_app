import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';

/// Loads the basic SQL autocomplete suggestions.
class LoadSqlBasicSuggestionsUseCase {
  /// Creates the use case backed by [_repository].
  const LoadSqlBasicSuggestionsUseCase(this._repository);

  final SqlBasicSuggestionsRepository _repository;

  /// Runs the use case.
  Future<Result<List<String>>> call() => _repository.load();
}
