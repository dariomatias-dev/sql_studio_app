import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';

class SettingsCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final IconData? icon;

  const SettingsCardWidget({
    super.key,
    this.onTap,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color(0xFFF2F2F2), width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 15.0,
              offset: const Offset(0.0, 8.0),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Container(
                height: 42.0,
                width: 42.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFEEEEEE),
                    width: 1.0,
                  ),
                ),
                child: Icon(icon, size: 20.0, color: Colors.black),
              ),
              const SizedBox(width: 16.0),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withAlpha(100),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.0,
              color: Colors.black.withAlpha(40),
            ),
          ],
        ),
      ),
    );
  }
}
