import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';

class SettingsCardWidget extends StatelessWidget {
  const SettingsCardWidget({
    this.onTap,
    required this.title,
    this.subtitle,
    this.icon,
    super.key,
  });

  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(fontSize: 12.0, color: Colors.black54),
              )
            : null,
        trailing: icon != null
            ? Icon(icon, size: 18.0, color: Colors.black87)
            : null,
      ),
    );
  }
}
