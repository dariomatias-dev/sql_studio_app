import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class SqlBasicSuggestionsNotifier extends ChangeNotifier {
  final _logger = Logger();

  final _suggestions = <String>[];
  bool isLoading = false;

  List<String> get suggestions => _suggestions;

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
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to load suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(AppFailure('Failed to load basic suggestions'));
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<Result<void>> addSuggestion(String suggestion) async {
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
    } catch (err, stackTrace) {
      _logger.e('Failed to add suggestion', error: err, stackTrace: stackTrace);

      return FailureResult(AppFailure('Failed to add suggestion'));
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<Result<void>> removeSuggestion(String suggestion) async {
    isLoading = true;

    notifyListeners();

    try {
      _suggestions.remove(suggestion);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to remove suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(AppFailure('Failed to remove suggestion'));
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

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
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to update suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(AppFailure('Failed to update suggestions'));
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
        ..addAll(List.from(defaultSqlBasicSuggestions));

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to reset suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(AppFailure('Failed to reset suggestions'));
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
