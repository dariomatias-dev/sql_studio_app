import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

/// Standardized inline error state, with an optional retry action.
///
/// This is for errors embedded directly in a screen's layout (e.g. a
/// failed inline fetch). Blocking errors that interrupt the user's flow
/// should keep using [DialogWidget]/`handleError` instead.
class ErrorStateWidget extends StatelessWidget {
  /// Creates an error state displaying [message].
  const ErrorStateWidget({
    required this.message,
    super.key,
    this.icon = Icons.error_outline_rounded,
    this.onRetry,
    this.retryText = 'Retry',
  });

  /// Error description shown to the user.
  final String message;

  /// Icon displayed above the message.
  final IconData icon;

  /// Called when the retry button is tapped. When `null`, no retry
  /// button is shown.
  final VoidCallback? onRetry;

  /// Label of the retry button, shown only when [onRetry] is non-null.
  final String retryText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: context.colors.error.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: context.colors.error),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 20),
              ButtonWidget(
                onPressed: onRetry,
                text: retryText,
                style: ButtonStyleType.red,
                height: 44,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
