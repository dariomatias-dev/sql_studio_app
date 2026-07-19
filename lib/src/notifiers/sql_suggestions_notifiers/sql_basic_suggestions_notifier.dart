import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

/// Manages the persisted list of basic SQL autocomplete suggestions.
class SqlBasicSuggestionsNotifier extends ChangeNotifier {
  final _logger = Logger();

  final _suggestions = <String>[];

  /// Whether a suggestions operation is currently in progress.
  bool isLoading = false;

  /// The currently known basic suggestions.
  List<String> get suggestions => _suggestions;

  /// Loads the basic suggestions from storage, falling back to defaults.
  Future<Result<void>> load() async {
    isLoading = true;

    notifyListeners();

    try {
      final stored = SharedPreferencesService.getStringList(
        SharedPreferencesKeys.sqlCommandsKey,
      );

      _suggestions
        ..clear()
        ..addAll(
          stored.isEmpty ? defaultSqlBasicSuggestions : List.from(stored),
        );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to load suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToLoadBasicSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Adds [suggestion] to the list if it isn't already present.
  Future<Result<void>> add(String suggestion) async {
    isLoading = true;

    notifyListeners();

    try {
      if (_suggestions.contains(suggestion)) {
        return const SuccessResult(null);
      }

      _suggestions.add(suggestion);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e('Failed to add suggestion', error: err, stackTrace: stackTrace);

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToAddBasicSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Replaces all stored suggestions with [newSuggestions].
  Future<Result<void>> updateSuggestions(List<String> newSuggestions) async {
    isLoading = true;

    notifyListeners();

    try {
      _suggestions
        ..clear()
        ..addAll(newSuggestions);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to update suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToUpdateBasicSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Removes [suggestion] from the list.
  Future<Result<void>> remove(String suggestion) async {
    isLoading = true;

    notifyListeners();

    try {
      _suggestions.remove(suggestion);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to remove suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToRemoveBasicSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Restores the default basic suggestions, overwriting stored ones.
  Future<Result<void>> resetSuggestions() async {
    isLoading = true;

    notifyListeners();

    try {
      _suggestions
        ..clear()
        ..addAll(List.from(defaultSqlBasicSuggestions));

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to reset suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToResetBasicSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
