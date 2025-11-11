import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/result.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

class WorkspaceLayoutNotifier extends ChangeNotifier {
  final logger = Logger();

  WorkspaceLayoutType _selectedLayout = WorkspaceLayoutType.split;

  WorkspaceLayoutType get selectedLayout => _selectedLayout;

  void load() {
    final savedLayout = SharedPreferencesService.getString(
      SharedPreferencesKeys.workspaceLayoutKey,
    );

    _selectedLayout = savedLayout == WorkspaceLayoutType.tabs.name
        ? WorkspaceLayoutType.tabs
        : WorkspaceLayoutType.split;

    notifyListeners();
  }

  Future<Result<void>> setLayout(WorkspaceLayoutType layout) async {
    try {
      _selectedLayout = layout;

      await SharedPreferencesService.setString(
        SharedPreferencesKeys.workspaceLayoutKey,
        layout == WorkspaceLayoutType.split ? 'split' : 'tabs',
      );

      notifyListeners();

      return const SuccessResult(null);
    } catch (err, stackTrace) {
      logger.e(
        'Error saving workspace layout',
        error: err,
        stackTrace: stackTrace,
      );

      return FailureResult(
        AppFailure('Failed to save workspace layout. Please try again.'),
      );
    }
  }
}
