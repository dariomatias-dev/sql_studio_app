import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/sql_advanced_suggestions_default.dart';
import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/services/sql_advanced_suggestions_service.dart';

class SqlAdvancedSuggestionsNotifier extends ChangeNotifier {
  final _service = SqlAdvancedSuggestionsService();
  final _logger = Logger();

  List<SqlAdvancedSuggestionModel> _suggestions = [];
  bool isLoading = false;
  String? error;

  List<SqlAdvancedSuggestionModel> get advancedSuggestions => _suggestions;

  Future<void> loadSuggestions() async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      _suggestions = await _service.getAll();
    } catch (err, stackTrace) {
      error = 'Failed to load suggestions';

      _logger.e(
        'Error loading advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );
    }

    isLoading = false;

    notifyListeners();
  }

  Future<bool> addSuggestion(SqlAdvancedSuggestionModel suggestion) async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      await _service.create(suggestion);

      _suggestions.add(suggestion);

      return true;
    } catch (err, stackTrace) {
      error = 'Failed to add suggestion';

      _logger.e(
        'Error adding advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return false;
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<bool> updateSuggestion(SqlAdvancedSuggestionModel suggestion) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _service.update(suggestion);

      final index = _suggestions.indexWhere((s) => s.id == suggestion.id);
      if (index != -1) _suggestions[index] = suggestion;

      return true;
    } catch (err, stackTrace) {
      error = 'Failed to update suggestion';

      _logger.e(
        'Error updating advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return false;
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<bool> removeSuggestion(String id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _service.delete(id);

      _suggestions.removeWhere((s) => s.id == id);

      return true;
    } catch (err, stackTrace) {
      error = 'Failed to delete suggestion';

      _logger.e(
        'Error deleting advanced suggestion',
        error: err,
        stackTrace: stackTrace,
      );

      return false;
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  void reorderSuggestions(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _suggestions.removeAt(oldIndex);
    _suggestions.insert(newIndex, item);
    notifyListeners();
  }

  Future<void> resetSuggestions() async {
    try {
      await _service.clear();

      await _service.addAll(sqlAdvancedSuggestionsDefault);

      await loadSuggestions();
    } catch (err, stackTrace) {
      error = 'Failed to reset suggestions';

      _logger.e(
        'Error resetting advanced suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      notifyListeners();
    }
  }

  void clearError() {
    error = null;

    notifyListeners();
  }
}
