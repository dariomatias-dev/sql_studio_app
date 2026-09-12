import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

/// Neutral replacement for the framework's red error screen, shown when a
/// widget fails to build in release.
class UnexpectedErrorWidget extends StatelessWidget {
  /// Creates the error placeholder.
  const UnexpectedErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final message = AppLocalizations.of(context).unexpectedError;

    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
