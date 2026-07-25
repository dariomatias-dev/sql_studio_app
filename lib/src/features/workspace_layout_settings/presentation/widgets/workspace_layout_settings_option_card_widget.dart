import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';

/// Selectable card representing a single workspace layout option.
class WorkspaceLayoutSettingsOptionCardWidget extends StatelessWidget {
  /// Creates a workspace layout option card.
  const WorkspaceLayoutSettingsOptionCardWidget({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    super.key,
  });

  /// Called when the user taps this card.
  final VoidCallback onTap;

  /// Icon representing the layout option.
  final IconData icon;

  /// Title of the layout option.
  final String title;

  /// Short description of the layout option.
  final String subtitle;

  /// Whether this layout is the currently selected one.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      border: selected
          ? Border.all(color: AppColors.black.withAlpha(140))
          : Border.all(color: AppColors.border),
      child: ListTile(
        leading: Icon(icon, color: AppColors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: AppColors.black54),
        ),
        trailing: selected
            ? const Icon(Icons.check, color: AppColors.black)
            : null,
      ),
    );
  }
}
