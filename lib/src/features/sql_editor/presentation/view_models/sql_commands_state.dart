import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';

/// Presentation state for running SQL commands against the active
/// database.
class SqlCommandsState {
  /// Creates the state, defaulting to no active database and no result.
  const SqlCommandsState({
    this.activeDatabase,
    this.result,
    this.isLoading = false,
    this.error,
    this.errorArgs,
    this.lastQuery,
    this.isDefaultDatabase = false,
  });

  /// The name of the database currently selected for query execution.
  final String? activeDatabase;

  /// The outcome of the most recently executed query.
  final Result<Object?>? result;

  /// Whether a query or reset operation is currently in progress.
  final bool isLoading;

  /// The localization key describing the last error, if any.
  final AppLocalizationsKey? error;

  /// Arguments to interpolate into the [error] localization message.
  final Map<String, Object?>? errorArgs;

  /// The SQL text of the last query that was run.
  final String? lastQuery;

  /// Whether the active database is one of the built-in default databases.
  final bool isDefaultDatabase;

  /// Returns a copy of this state with the given fields replaced.
  ///
  /// Pass [clearResult] or [clearError] to explicitly reset those fields
  /// to `null` instead of keeping their current value.
  SqlCommandsState copyWith({
    String? activeDatabase,
    Result<Object?>? result,
    bool? isLoading,
    AppLocalizationsKey? error,
    Map<String, Object?>? errorArgs,
    String? lastQuery,
    bool? isDefaultDatabase,
    bool clearActiveDatabase = false,
    bool clearResult = false,
    bool clearError = false,
  }) {
    return SqlCommandsState(
      activeDatabase: clearActiveDatabase
          ? null
          : (activeDatabase ?? this.activeDatabase),
      result: clearResult ? null : (result ?? this.result),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      errorArgs: clearError ? null : (errorArgs ?? this.errorArgs),
      lastQuery: lastQuery ?? this.lastQuery,
      isDefaultDatabase: isDefaultDatabase ?? this.isDefaultDatabase,
    );
  }
}
