import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
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
          ? Border.all(color: context.colors.black.withAlpha(140))
          : Border.all(color: context.colors.border),
      child: ListTile(
        leading: Icon(icon, color: context.colors.black87),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: context.colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: context.colors.black54),
        ),
        trailing: selected
            ? Icon(Icons.check, color: context.colors.black)
            : null,
      ),
    );
  }
}
