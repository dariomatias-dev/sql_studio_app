import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/shared/widgets/unexpected_error_widget.dart';

/// Routes framework and platform errors to [logger] and replaces the
/// release error widget with a neutral one, so a failed build shows a
/// readable surface instead of the red error screen.
void installErrorHandlers(AppLogger logger) {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);

    logger.error(
      'Uncaught Flutter error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error(
      'Uncaught platform error',
      error: error,
      stackTrace: stackTrace,
    );

    return true;
  };

  if (kReleaseMode) {
    ErrorWidget.builder = (details) => const UnexpectedErrorWidget();
  }
}
