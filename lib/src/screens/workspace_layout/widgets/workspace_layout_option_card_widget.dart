import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';

class WorkspaceLayoutOptionCardWidget extends StatelessWidget {
  const WorkspaceLayoutOptionCardWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        trailing: selected
            ? const Icon(Icons.check, color: Colors.green)
            : null,
      ),
    );
  }
}
