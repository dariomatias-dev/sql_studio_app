import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

/// Shown when the app cannot load its local state on startup, offering a
/// retry and, for state that will not load however often it is retried,
/// a way to clear it.
class StartupFailureScreen extends StatefulWidget {
  /// Creates the screen with its [onRetry] and [onClearAppData] actions.
  const StartupFailureScreen({
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
  State<StartupFailureScreen> createState() => _StartupFailureScreenState();
}

class _StartupFailureScreenState extends State<StartupFailureScreen> {
  var _isBusy = false;

  Future<void> _run(Future<void> Function() action) async {
    if (_isBusy) return;

    setState(() => _isBusy = true);

    try {
      await action();
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _confirmClearAppData() async {
    final appLocalizations = AppLocalizations.of(context)!;

    final confirmed = await ConfirmationDialogWidget.show<bool>(
      context,
      title: appLocalizations.clearAppData,
      description: appLocalizations.clearAppDataConfirmation,
      confirmButton: Builder(
        builder: (dialogContext) => ButtonWidget(
          onPressed: () => Navigator.pop(dialogContext, true),
          style: ButtonStyleType.red,
          text: appLocalizations.clearAppData,
        ),
      ),
    );

    if (confirmed ?? false) {
      await _run(widget.onClearAppData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  size: 56,
                  color: context.colors.textPrimary,
                ),
                const SizedBox(height: 24),
                Text(
                  appLocalizations.startupFailedTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  appLocalizations.startupFailedMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.colors.textMuted,
                  ),
                ),
                const SizedBox(height: 32),
                ButtonWidget(
                  onPressed: _isBusy ? null : () => _run(widget.onRetry),
                  style: ButtonStyleType.black,
                  text: appLocalizations.retry,
                  child: _isBusy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                ),
                const SizedBox(height: 12),
                ButtonWidget(
                  onPressed: _isBusy ? null : _confirmClearAppData,
                  style: ButtonStyleType.red,
                  text: appLocalizations.clearAppData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
