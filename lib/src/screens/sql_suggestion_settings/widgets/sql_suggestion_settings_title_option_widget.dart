import 'package:flutter/material.dart';

class SqlSuggestionSettingsTitleOptionWidget extends StatelessWidget {
  const SqlSuggestionSettingsTitleOptionWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
