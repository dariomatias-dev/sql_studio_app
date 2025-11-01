import 'package:flutter/material.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Column(spacing: 8.0, children: children),
      ],
    );
  }
}
