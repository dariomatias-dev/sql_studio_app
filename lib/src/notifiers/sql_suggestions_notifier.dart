import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/constants/sql_commands.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class SqlSuggestionsNotifier extends ChangeNotifier {
  final _commands = <String>[];
  final _suggestions = <String>[];

  List<String> get commands => _suggestions.isEmpty ? _commands : _suggestions;

  Future<void> loadCommands() async {
    _commands
      ..clear()
      ..addAll(
        SharedPreferencesService.getStringList(
          SharedPreferencesKeys.sqlCommandsKey,
        ),
      );

    if (_commands.isEmpty) {
      _commands
        ..clear()
        ..addAll(List.from(sqlCommands));
    }

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
      ..addAll(List.from(commands));

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

  void updateSuggestions(String input) {
    final query = input.trim().toUpperCase();
    if (query.isEmpty) {
      _suggestions.clear();
    } else {
      _suggestions
        ..clear()
        ..addAll(
          _commands
              .where((cmd) => cmd.toUpperCase().startsWith(query))
              .toList(),
        );
    }

    notifyListeners();
  }

  void clearSuggestions() {
    _suggestions.clear();

    notifyListeners();
  }
}
