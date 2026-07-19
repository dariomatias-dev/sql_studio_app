import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

/// The kind of SQL autocomplete suggestions that can be enabled.
enum SuggestionType {
  /// Suggestions based on basic SQL keywords.
  basic,

  /// Suggestions based on schema-aware, advanced analysis.
  advanced,
}

/// Manages which SQL suggestion features are enabled and persists them.
class SqlSuggestionsNotifier extends ChangeNotifier {
  /// Logger used to report failures while loading or saving settings.
  final logger = Logger();

  bool _useBasicSuggestions = true;
  bool _useAdvancedSuggestions = false;
  bool _useCharacterSuggestions = true;

  /// Whether basic keyword suggestions are enabled.
  bool get useBasicSuggestions => _useBasicSuggestions;

  /// Whether advanced, schema-aware suggestions are enabled.
  bool get useAdvancedSuggestions => _useAdvancedSuggestions;

  /// Whether character-triggered suggestions are enabled.
  bool get useCharacterSuggestions => _useCharacterSuggestions;

  /// Loads the persisted suggestion settings.
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
    } on Exception catch (err, stackTrace) {
      logger.e(
        'Error loading SQL suggestions',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.failedToLoadSqlSuggestions),
      );
    }
  }

  /// Persists the current suggestion settings.
  Future<Result<void>> saveSettings() async {
    try {
      await SharedPreferencesService.setBool(
        SharedPreferencesKeys.useBasicSuggestionsKey,
        value: _useBasicSuggestions,
      );

      await SharedPreferencesService.setBool(
        SharedPreferencesKeys.useAdvancedSuggestionsKey,
        value: _useAdvancedSuggestions,
      );

      await SharedPreferencesService.setBool(
        SharedPreferencesKeys.useCharacterSuggestionsKey,
        value: _useCharacterSuggestions,
      );

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      logger.e(
        'Error saving SQL suggestions settings',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        DatabaseFailure(AppLocalizationsKey.failedToSaveSqlSuggestionsSettings),
      );
    }
  }

  /// Enables or disables basic suggestions, disabling advanced ones when
  /// [value] is `true`.
  void setBasicSuggestions({required bool value}) {
    _useBasicSuggestions = value;

    if (value) _useAdvancedSuggestions = false;

    notifyListeners();
  }

  /// Enables or disables advanced suggestions, disabling basic ones when
  /// [value] is `true`.
  void setAdvancedSuggestions({required bool value}) {
    _useAdvancedSuggestions = value;

    if (value) _useBasicSuggestions = false;

    notifyListeners();
  }

  /// Enables or disables character-triggered suggestions.
  void setCharacterSuggestions({required bool value}) {
    _useCharacterSuggestions = value;

    notifyListeners();
  }
}
