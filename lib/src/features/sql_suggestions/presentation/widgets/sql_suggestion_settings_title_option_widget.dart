import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// Section title label used within the SQL suggestion settings screen.
class SqlSuggestionSettingsTitleOptionWidget extends StatelessWidget {
  /// Creates a section title displaying [title].
  const SqlSuggestionSettingsTitleOptionWidget({
    required this.title,
    super.key,
  });

  /// Text displayed as the section title.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: context.colors.black87,
      ),
    );
  }
}
