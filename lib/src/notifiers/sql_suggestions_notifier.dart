import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/sql_advanced_suggestions_default.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/constants/sql_commands.dart';
import 'package:sql_studio/src/core/types/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

enum SuggestionType { basic, advanced }

class SqlSuggestionsNotifier extends ChangeNotifier {
  final _commands = <String>[];
  final _suggestions = <String>[];
  final _advancedSuggestions = <SqlAdvancedSuggestionModel>[];

  bool _useBasicSuggestions = true;
  bool _useAdvancedSuggestions = false;
  bool _useCharacterSuggestions = true;

  bool get useBasicSuggestions => _useBasicSuggestions;
  bool get useAdvancedSuggestions => _useAdvancedSuggestions;
  bool get useCharacterSuggestions => _useCharacterSuggestions;

  List<String> get commands => _suggestions.isEmpty ? _commands : _suggestions;
  List<SqlAdvancedSuggestionModel> get advancedSuggestions => _advancedSuggestions.isEmpty ? sqlAdvancedSuggestionsDefault : _advancedSuggestions;

  Future<void> loadCommands() async {
    _commands
      ..clear()
      ..addAll(
        SharedPreferencesService.getStringList(
          SharedPreferencesKeys.sqlCommandsKey,
        ),
      );

    if (_commands.isEmpty) {
      _commands.addAll(List.from(sqlCommands));
    }

    final savedAdvanced = SharedPreferencesService.getStringList(
      'advancedSuggestions',
    );

    _advancedSuggestions
      ..clear()
      ..addAll(
        savedAdvanced.map((item) {
          final parts = item.split('|');
          return SqlAdvancedSuggestionModel(
            label: parts[0],
            code: parts.length > 1 ? parts[1] : '',
          );
        }),
      );

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

  Future<void> addCommand(String command) async {
    if (!_commands.contains(command)) {
      _commands.add(command);

      await SharedPreferencesService.setStringList(
        SharedPreferencesKeys.sqlCommandsKey,
        _commands,
      );

      notifyListeners();
    }
  }

  Future<void> updateCommands(List<String> commands) async {
    _commands
      ..clear()
      ..addAll(commands);

    await SharedPreferencesService.setStringList(
      SharedPreferencesKeys.sqlCommandsKey,
      _commands,
    );

    notifyListeners();
  }

  Future<void> removeCommand(String command) async {
    _commands.remove(command);

    await SharedPreferencesService.setStringList(
      SharedPreferencesKeys.sqlCommandsKey,
      _commands,
    );

    notifyListeners();
  }

  Future<void> addAdvancedSuggestion(String label, String code) async {
    final exists = _advancedSuggestions.any((s) => s.label == label);
    if (exists) return;

    _advancedSuggestions.add(SqlAdvancedSuggestionModel(label: label, code: code));
    await _saveAdvancedSuggestions();
  }

  Future<void> removeAdvancedSuggestion(String label) async {
    _advancedSuggestions.removeWhere((s) => s.label == label);
    await _saveAdvancedSuggestions();
  }

  Future<void> updateAdvancedSuggestions(
    List<SqlAdvancedSuggestionModel> suggestions,
  ) async {
    _advancedSuggestions
      ..clear()
      ..addAll(suggestions);
    await _saveAdvancedSuggestions();
  }

  Future<void> _saveAdvancedSuggestions() async {
    final data = _advancedSuggestions
        .map((e) => '${e.label}|${e.code.replaceAll('|', '¦')}')
        .toList();

    await SharedPreferencesService.setStringList('advancedSuggestions', data);

    notifyListeners();
  }

  void updateSuggestions(String input) {
    final query = input.trim().toUpperCase();

    if (query.isEmpty) {
      _suggestions.clear();
    } else {
      _suggestions
        ..clear()
        ..addAll(_commands.where((cmd) => cmd.toUpperCase().startsWith(query)));
    }

    notifyListeners();
  }

  void clearSuggestions() {
    _suggestions.clear();
    notifyListeners();
  }
}
