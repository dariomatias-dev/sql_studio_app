import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_advanced_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/sql_advanced_suggestions_service.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class SqlAdvancedSuggestionsNotifier extends ChangeNotifier {
  final _logger = Logger();
  final _service = SqlAdvancedSuggestionsService();

  final _suggestions = <SqlAdvancedSuggestionModel>[];
  bool isLoading = false;

  List<SqlAdvancedSuggestionModel> get suggestions => _suggestions;

  Future<Result<void>> load() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAll();

      _suggestions
        ..clear()
        ..addAll(List<SqlAdvancedSuggestionModel>.from(result));

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to load advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToLoadAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<Result<void>> addSuggestion(
    SqlAdvancedSuggestionModel suggestion,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      await _service.create(suggestion);

      _suggestions.add(suggestion);

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to add advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToAddAdvancedSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

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
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to update advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToUpdateAdvancedSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<Result<void>> removeSuggestion(String id) async {
    isLoading = true;

    notifyListeners();

    try {
      await _service.delete(id);

      _suggestions.removeWhere((s) => s.id == id);

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to remove advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToRemoveAdvancedSuggestion),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

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
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to save all advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveAllAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<Result<void>> reorderSuggestions(
    List<SqlAdvancedSuggestionModel> newOrder,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      final updated = <SqlAdvancedSuggestionModel>[];

      for (int i = 0; i < newOrder.length; i++) {
        final s = newOrder[i].copyWith(orderIndex: i);

        await _service.update(s);

        updated.add(s);
      }

      _suggestions
        ..clear()
        ..addAll(updated);

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to reorder advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToReorderAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

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
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to reset advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure(AppLocalizationsKey.failedToResetAdvancedSuggestions),
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
