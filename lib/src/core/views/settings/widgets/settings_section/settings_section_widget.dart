import 'package:flutter/material.dart';

/// Groups related settings entries under a titled section header.
class SettingsSectionWidget extends StatelessWidget {
  /// Creates a settings section labeled with [title], wrapping [children].
  const SettingsSectionWidget({
    required this.title,
    required this.children,
    super.key,
  });

  /// Header label for this section.
  final String title;

  /// Settings entries displayed within this section.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 28, 0, 20),
          child: Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: children.map((child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: child,
            );
          }).toList(),
        ),
      ],
    );
  }
}
