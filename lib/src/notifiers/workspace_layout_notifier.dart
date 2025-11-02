import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class WorkspaceLayoutNotifier extends ChangeNotifier {
  WorkspaceLayoutType _selectedLayout = WorkspaceLayoutType.split;

  WorkspaceLayoutType get selectedLayout => _selectedLayout;

  void load() {
    final savedLayout = SharedPreferencesService.getString(
      SharedPreferencesKeys.workspaceLayoutKey,
    );

    if (savedLayout == 'tabs') {
      _selectedLayout = WorkspaceLayoutType.tabs;
    } else {
      _selectedLayout = WorkspaceLayoutType.split;
    }

    notifyListeners();
  }

  Future<void> setLayout(WorkspaceLayoutType layout) async {
    _selectedLayout = layout;

    await SharedPreferencesService.setString(
      SharedPreferencesKeys.workspaceLayoutKey,
      layout == WorkspaceLayoutType.split ? 'split' : 'tabs',
    );

    notifyListeners();
  }
}
