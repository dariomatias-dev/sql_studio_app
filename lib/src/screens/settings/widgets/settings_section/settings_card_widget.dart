import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';

/// A tappable card used to present a single settings entry, with an
/// optional leading icon and subtitle.
class SettingsCardWidget extends StatelessWidget {
  /// Creates a settings card with the given [title].
  const SettingsCardWidget({
    required this.title,
    super.key,
    this.onTap,
    this.subtitle,
    this.icon,
  });

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Main label describing the setting.
  final String title;

  /// Optional secondary text shown below the title.
  final String? subtitle;

  /// Optional leading icon shown before the title.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF2F2F2), width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFEEEEEE),
                  ),
                ),
                child: Icon(icon, size: 20, color: Colors.black),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
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
              size: 20,
              color: Colors.black.withAlpha(40),
            ),
          ],
        ),
      ),
    );
  }
}
