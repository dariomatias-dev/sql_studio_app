import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';

/// A tappable row used to present a single settings entry, with a
/// leading icon, title, and trailing chevron.
class SettingsCardWidget extends StatelessWidget {
  /// Creates a settings row with the given [title] and [icon].
  const SettingsCardWidget({
    required this.title,
    required this.icon,
    super.key,
    this.onTap,
    this.value,
  });

  /// Called when the row is tapped.
  final VoidCallback? onTap;

  /// Main label describing the setting.
  final String title;

  /// Leading icon representing the setting.
  final IconData icon;

  /// Optional current value shown before the chevron (e.g. the selected
  /// language).
  final String? value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 22, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            if (value != null) ...<Widget>[
              Text(
                value!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 8),
            ],
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
