import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class SqlCommandsNotifier extends ChangeNotifier {
  List<String> _commands = [];

  List<String> get commands => _commands;

  void loadCommands() {
    _commands = SharedPreferencesService.getStringList(
      SharedPreferencesKeys.sqlCommandsKey,
    );

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
    _commands = List.from(commands);

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
}
