import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// Standardized full-area loading indicator, optionally labeled.
class LoadingStateWidget extends StatelessWidget {
  /// Creates a loading state with an optional [message] below the spinner.
  const LoadingStateWidget({super.key, this.message, this.size = 28});

  /// Text displayed below the spinner. When `null`, no text is shown.
  final String? message;

  /// Diameter of the spinner.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2.5,
            ),
          ),
          if (message != null) ...<Widget>[
            const SizedBox(height: 16),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
