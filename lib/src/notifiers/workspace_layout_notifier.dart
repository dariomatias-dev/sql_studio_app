import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

/// Manages the selected workspace layout and persists it between sessions.
class WorkspaceLayoutNotifier extends ChangeNotifier {
  /// Logger used to report failures while persisting the layout.
  final logger = Logger();

  WorkspaceLayoutType _selectedLayout = WorkspaceLayoutType.split;

  /// The currently selected workspace layout.
  WorkspaceLayoutType get selectedLayout => _selectedLayout;

  /// Loads the previously persisted workspace layout, if any.
  void load() {
    final savedLayout = SharedPreferencesService.getString(
      SharedPreferencesKeys.workspaceLayoutKey,
    );

    _selectedLayout = savedLayout == WorkspaceLayoutType.tabs.name
        ? WorkspaceLayoutType.tabs
        : WorkspaceLayoutType.split;

    notifyListeners();
  }

  /// Selects [layout] as the active workspace layout and persists it.
  Future<Result<void>> setLayout(WorkspaceLayoutType layout) async {
    try {
      _selectedLayout = layout;

      await SharedPreferencesService.setString(
        SharedPreferencesKeys.workspaceLayoutKey,
        layout == WorkspaceLayoutType.split ? 'split' : 'tabs',
      );

      notifyListeners();

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      logger.e(
        'Error saving workspace layout',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToSaveWorkspaceLayout),
      );
    }
  }
}
