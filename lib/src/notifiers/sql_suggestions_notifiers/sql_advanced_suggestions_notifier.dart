import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/sql_advanced_suggestions_service.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

/// Manages the persisted list of advanced SQL autocomplete suggestions.
class SqlAdvancedSuggestionsNotifier extends ChangeNotifier {
  final _logger = Logger();
  final _service = SqlAdvancedSuggestionsService();

  final _suggestions = <SqlAdvancedSuggestionModel>[];

  /// Whether a suggestions operation is currently in progress.
  bool isLoading = false;

  /// The currently known advanced suggestions.
  List<SqlAdvancedSuggestionModel> get suggestions => _suggestions;

  /// Loads all advanced suggestions from storage.
  Future<Result<void>> load() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAll();

      _suggestions
        ..clear()
        ..addAll(List<SqlAdvancedSuggestionModel>.from(result));

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to load advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToLoadAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Persists [suggestion] and adds it to the current list.
  Future<Result<void>> addSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      await _service.create(suggestion);

      _suggestions.add(suggestion);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to add advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToAddAdvancedSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Persists changes to [suggestion] and updates it in the current list.
  Future<Result<void>> updateSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      await _service.update(suggestion);

      final index = _suggestions.indexWhere((s) => s.id == suggestion.id);
      if (index != -1) _suggestions[index] = suggestion;

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to update advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToUpdateAdvancedSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Deletes the suggestion identified by [id] from storage and the list.
  Future<Result<void>> removeSuggestion(String id) async {
    isLoading = true;

    notifyListeners();

    try {
      await _service.delete(id);

      _suggestions.removeWhere((s) => s.id == id);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to remove advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToRemoveAdvancedSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Replaces all stored suggestions with [newSuggestions].
  Future<Result<void>> saveAllSuggestions(
    List<SqlAdvancedSuggestionModel> newSuggestions,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      await _service.clear();
      await _service.addAll(newSuggestions);

      _suggestions
        ..clear()
        ..addAll(newSuggestions);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to save all advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveAllAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Persists a new ordering for the suggestions, given as [newOrder].
  Future<Result<void>> reorderSuggestions(
    List<SqlAdvancedSuggestionModel> newOrder,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      final updated = <SqlAdvancedSuggestionModel>[];

      for (var i = 0; i < newOrder.length; i++) {
        final s = newOrder[i].copyWith(orderIndex: i);

        await _service.update(s);

        updated.add(s);
      }

      _suggestions
        ..clear()
        ..addAll(updated);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to reorder advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToReorderAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  /// Restores the default advanced suggestions, overwriting stored ones.
  Future<Result<void>> resetSuggestions() async {
    isLoading = true;

    notifyListeners();

    try {
      _suggestions
        ..clear()
        ..addAll(
          List<SqlAdvancedSuggestionModel>.from(defaultSqlAdvancedSuggestions),
        );

      await _service.clear();
      await _service.addAll(_suggestions);

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to reset advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToResetAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
