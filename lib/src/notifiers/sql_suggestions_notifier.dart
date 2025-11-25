import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

enum SuggestionType { basic, advanced }

class SqlSuggestionsNotifier extends ChangeNotifier {
  final logger = Logger();

  bool _useBasicSuggestions = true;
  bool _useAdvancedSuggestions = false;
  bool _useCharacterSuggestions = true;

  bool get useBasicSuggestions => _useBasicSuggestions;
  bool get useAdvancedSuggestions => _useAdvancedSuggestions;
  bool get useCharacterSuggestions => _useCharacterSuggestions;

  Future<Result<void>> load() async {
    try {
      _useBasicSuggestions = SharedPreferencesService.getBool(
        SharedPreferencesKeys.useBasicSuggestionsKey,
        defaultValue: true,
      );

      _useAdvancedSuggestions = SharedPreferencesService.getBool(
        SharedPreferencesKeys.useAdvancedSuggestionsKey,
      );

      _useCharacterSuggestions = SharedPreferencesService.getBool(
        SharedPreferencesKeys.useCharacterSuggestionsKey,
        defaultValue: true,
      );

      notifyListeners();

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      logger.e(
        'Error loading SQL suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(DatabaseFailure('Failed to load SQL suggestions'));
    }
  }

  Future<Result<void>> saveSettings() async {
    try {
      await SharedPreferencesService.setBool(
        SharedPreferencesKeys.useBasicSuggestionsKey,
        _useBasicSuggestions,
      );

      await SharedPreferencesService.setBool(
        SharedPreferencesKeys.useAdvancedSuggestionsKey,
        _useAdvancedSuggestions,
      );

      await SharedPreferencesService.setBool(
        SharedPreferencesKeys.useCharacterSuggestionsKey,
        _useCharacterSuggestions,
      );

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      logger.e(
        'Error saving SQL suggestions settings',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        DatabaseFailure('Failed to save SQL suggestions settings'),
      );
    }
  }

  void setBasicSuggestions(bool value) {
    _useBasicSuggestions = value;

    if (value) _useAdvancedSuggestions = false;

    notifyListeners();
  }

  void setAdvancedSuggestions(bool value) {
    _useAdvancedSuggestions = value;

    if (value) _useBasicSuggestions = false;

    notifyListeners();
  }

  void setCharacterSuggestions(bool value) {
    _useCharacterSuggestions = value;

    notifyListeners();
  }
}
