/// Records diagnostic messages, hiding the logging package from callers
/// so output can be silenced in tests and downgraded in release.
abstract interface class AppLogger {
  /// Records an expected, non-failing event.
  void info(String message);

  /// Records a recoverable problem.
  void warning(String message, {Object? error, StackTrace? stackTrace});

  /// Records a failure, with its [error] and [stackTrace] when available.
  void error(String message, {Object? error, StackTrace? stackTrace});
}
