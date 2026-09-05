import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/error/error_handlers.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';

class _RecordingAppLogger implements AppLogger {
  final messages = <String>[];
  final errors = <Object?>[];

  @override
  void info(String message) => messages.add(message);

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    messages.add(message);
    errors.add(error);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    messages.add(message);
    errors.add(error);
  }
}

void main() {
  late FlutterExceptionHandler? previousOnError;
  late FlutterExceptionHandler previousPresentError;
  late ErrorCallback? previousPlatformOnError;
  late _RecordingAppLogger logger;
  late List<FlutterErrorDetails> presented;

  setUp(() {
    previousOnError = FlutterError.onError;
    previousPresentError = FlutterError.presentError;
    previousPlatformOnError = PlatformDispatcher.instance.onError;
    logger = _RecordingAppLogger();
    presented = <FlutterErrorDetails>[];

    // Keeps the handler's report out of the test output.
    FlutterError.presentError = presented.add;
  });

  tearDown(() {
    FlutterError.onError = previousOnError;
    FlutterError.presentError = previousPresentError;
    PlatformDispatcher.instance.onError = previousPlatformOnError;
  });

  test('FlutterError.onError presents and reports the exception', () {
    installErrorHandlers(logger);

    final exception = Exception('boom');

    FlutterError.onError!(FlutterErrorDetails(exception: exception));

    expect(presented.single.exception, exception);
    expect(logger.messages, contains('Uncaught Flutter error'));
    expect(logger.errors, contains(exception));
  });

  test('PlatformDispatcher.onError handles and reports the error', () {
    installErrorHandlers(logger);

    final error = Exception('boom');
    final handled = PlatformDispatcher.instance.onError!(
      error,
      StackTrace.current,
    );

    expect(handled, isTrue);
    expect(logger.messages, contains('Uncaught platform error'));
    expect(logger.errors, contains(error));
  });

  test('keeps the framework error widget outside release builds', () {
    final previousBuilder = ErrorWidget.builder;

    installErrorHandlers(logger);

    expect(ErrorWidget.builder, same(previousBuilder));
  });
}
