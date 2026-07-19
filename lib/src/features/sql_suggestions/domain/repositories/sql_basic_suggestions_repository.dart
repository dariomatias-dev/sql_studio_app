import 'package:sql_studio/src/core/error/result.dart';

/// Persists and retrieves the basic SQL autocomplete suggestions.
abstract interface class SqlBasicSuggestionsRepository {
  /// Loads the basic suggestions from storage, falling back to defaults.
  Future<Result<List<String>>> load();

  /// Persists [suggestions], replacing the stored list.
  Future<Result<void>> save(List<String> suggestions);
}
