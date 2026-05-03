import 'package:flutter/material.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 28.0, 0.0, 20.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 4.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: children.map((Widget child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: child,
            );
          }).toList(),
        ),
      ],
    );
  }
}
