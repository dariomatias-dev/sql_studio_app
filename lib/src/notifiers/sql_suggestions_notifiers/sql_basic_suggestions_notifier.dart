import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class SqlBasicSuggestionsNotifier extends ChangeNotifier {
  final _logger = Logger();

  List<String> _suggestions = <String>[];

  bool isLoading = false;
  String? error;

  List<String> get suggestions => _suggestions;

  Future<void> load() async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      final storedSuggestions = SharedPreferencesService.getStringList(
        SharedPreferencesKeys.sqlCommandsKey,
      );

      _suggestions = storedSuggestions.isNotEmpty
          ? storedSuggestions
          : List.from(defaultSqlBasicSuggestions);
    } catch (err, stackTrace) {
      error = 'Failed to load basic SQL suggestions';

      _logger.e(
        'Error loading basic SQL suggestions',
        error: err,
        stackTrace: stackTrace,
      );
    }

    isLoading = false;

    notifyListeners();
  }

  Future<bool> addSuggestion(String suggestion) async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      if (_suggestions.contains(suggestion)) return true;

      _suggestions.add(suggestion);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return true;
    } catch (err, stackTrace) {
      error = 'Failed to add basic suggestion';

      _logger.e(
        'Error adding basic SQL suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateSuggestions(List<String> suggestions) async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      _suggestions
        ..clear()
        ..addAll(suggestions);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return true;
    } catch (err, stackTrace) {
      error = 'Failed to update basic suggestions';

      _logger.e(
        'Error updating basic SQL suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> removeSuggestion(String suggestion) async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      _suggestions.remove(suggestion);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _suggestions,
      );

      return true;
    } catch (err, stackTrace) {
      error = 'Failed to remove basic suggestion';

      _logger.e(
        'Error removing basic SQL suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetSuggestions() async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        List.from(defaultSqlBasicSuggestions),
      );

      _suggestions = List.from(defaultSqlBasicSuggestions);
    } catch (err, stackTrace) {
      error = 'Failed to reset basic SQL suggestions';

      _logger.e(
        'Error resetting basic SQL suggestions',
        error: err,
        stackTrace: stackTrace,
      );
    }

    isLoading = false;

    notifyListeners();
  }

  void clearError() {
    error = null;

    notifyListeners();
  }
}
