import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

enum SuggestionType { basic, advanced }

class SqlSuggestionsNotifier extends ChangeNotifier {
  bool _useBasicSuggestions = true;
  bool _useAdvancedSuggestions = false;
  bool _useCharacterSuggestions = true;

  bool get useBasicSuggestions => _useBasicSuggestions;
  bool get useAdvancedSuggestions => _useAdvancedSuggestions;
  bool get useCharacterSuggestions => _useCharacterSuggestions;

  Future<void> load() async {
    _useBasicSuggestions = SharedPreferencesService.getBool(
      'useBasicSuggestions',
      defaultValue: true,
    );

    _useAdvancedSuggestions = SharedPreferencesService.getBool(
      'useAdvancedSuggestions',
    );

    _useCharacterSuggestions = SharedPreferencesService.getBool(
      'useCharacterSuggestions',
      defaultValue: true,
    );

    notifyListeners();
  }

  Future<void> saveSettings() async {
    await SharedPreferencesService.setBool(
      'useBasicSuggestions',
      _useBasicSuggestions,
    );

    await SharedPreferencesService.setBool(
      'useAdvancedSuggestions',
      _useAdvancedSuggestions,
    );

    await SharedPreferencesService.setBool(
      'useCharacterSuggestions',
      _useCharacterSuggestions,
    );
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
