import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/logging/logger_app_logger.dart';

class _MockLogger extends Mock implements Logger {}

void main() {
  late _MockLogger logger;
  late LoggerAppLogger appLogger;

  setUp(() {
    logger = _MockLogger();
    appLogger = LoggerAppLogger(logger: logger);
  });

  test('info forwards the message at info level', () {
    appLogger.info('seeded');

    verify(() => logger.i('seeded')).called(1);
  });

  test('warning forwards the error and stack trace', () {
    final error = Exception('boom');
    final stackTrace = StackTrace.current;

    appLogger.warning('missing', error: error, stackTrace: stackTrace);

    verify(
      () => logger.w('missing', error: error, stackTrace: stackTrace),
    ).called(1);
  });

  test('error forwards the error and stack trace', () {
    final error = Exception('boom');
    final stackTrace = StackTrace.current;

    appLogger.error('failed', error: error, stackTrace: stackTrace);

    verify(
      () => logger.e('failed', error: error, stackTrace: stackTrace),
    ).called(1);
  });
}
