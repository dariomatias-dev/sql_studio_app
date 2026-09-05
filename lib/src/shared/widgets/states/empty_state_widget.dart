import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// Standardized "no data" placeholder, with an optional action slot.
class EmptyStateWidget extends StatelessWidget {
  /// Creates an empty state displaying [message].
  const EmptyStateWidget({
    required this.message,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  /// Description shown to the user.
  final String message;

  /// Icon displayed above the message.
  final IconData icon;

  /// Optional widget displayed below the message, e.g. a call-to-action
  /// button. When `null`, nothing is shown.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: context.colors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: context.colors.controlInactive,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colors.textMuted,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            if (action != null) ...<Widget>[
              const SizedBox(height: 20),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
