import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sql_studio/src/core/logging/app_logger.dart';

/// Deletes everything the app stores on the device. The last resort when
/// startup fails on data that will not load however often it is retried.
class LocalStateService {
  /// Creates the service, recording failures through [_logger].
  const LocalStateService(this._logger);

  final AppLogger _logger;

  /// Removes the stored preferences and every local database file. Each
  /// half is attempted even when the other fails.
  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } on Object catch (err, stackTrace) {
      _logger.error(
        'Failed to clear preferences',
        error: err,
        stackTrace: stackTrace,
      );
    }

    try {
      final directory = Directory(await getDatabasesPath());

      if (directory.existsSync()) {
        await directory.delete(recursive: true);
      }
    } on Object catch (err, stackTrace) {
      _logger.error(
        'Failed to delete the local databases',
        error: err,
        stackTrace: stackTrace,
      );
    }
  }
}
