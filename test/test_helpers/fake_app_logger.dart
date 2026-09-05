import 'package:sql_studio/src/core/logging/app_logger.dart';

/// [AppLogger] that discards every message, keeping test output clean.
class FakeAppLogger implements AppLogger {
  @override
  void info(String message) {}

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {}
}
