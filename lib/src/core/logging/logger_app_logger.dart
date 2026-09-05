import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:sql_studio/src/core/logging/app_logger.dart';

/// [AppLogger] backed by the `logger` package, printing at warning level
/// and above in release builds.
class LoggerAppLogger implements AppLogger {
  /// Creates the logger, optionally over an existing [logger].
  LoggerAppLogger({Logger? logger})
    : _logger =
          logger ?? Logger(level: kReleaseMode ? Level.warning : Level.debug);

  final Logger _logger;

  @override
  void info(String message) => _logger.i(message);

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
