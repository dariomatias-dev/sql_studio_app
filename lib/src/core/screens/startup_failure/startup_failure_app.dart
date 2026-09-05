import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/screens/startup_failure/startup_failure_screen.dart';
import 'package:sql_studio/src/shared/utils/text_scaling.dart';

/// Minimal app shown when startup fails, before any provider container
/// exists: theme and localization only, hosting [StartupFailureScreen].
class StartupFailureApp extends StatelessWidget {
  /// Creates the fallback app with its [onRetry] and [onClearAppData]
  /// actions.
  const StartupFailureApp({
    required this.onRetry,
    required this.onClearAppData,
    super.key,
  });

  /// Runs the startup sequence again.
  final Future<void> Function() onRetry;

  /// Deletes every database and setting stored on the device, then runs
  /// the startup sequence again.
  final Future<void> Function() onClearAppData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: clampTextScaling,
      home: StartupFailureScreen(
        onRetry: onRetry,
        onClearAppData: onClearAppData,
      ),
    );
  }
}
