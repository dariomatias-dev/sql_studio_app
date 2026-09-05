import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

/// Special characters commonly used in SQL statements, shown as quick
/// insertion buttons in [SqlCharacterBarWidget].
const characters = <String>['(', ')', ';', '!', '=', '*', '%', "'", '"'];

/// Horizontal bar of quick-insert buttons for common SQL punctuation
/// characters.
class SqlCharacterBarWidget extends StatelessWidget {
  /// Creates a character insertion bar.
  const SqlCharacterBarWidget({required this.onInsertCommand, super.key});

  /// Called with the character to insert when a button is tapped.
  final void Function(String command, {String? selectText}) onInsertCommand;

  @override
  Widget build(BuildContext context) {
    return SqlSuggestionsBarBaseWidget(
      onTap: (index) => onInsertCommand(characters[index]),
      itemCount: characters.length,
      itemPadding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: AppSpacing.md,
      ),
      itemBuilder: (index) => characters[index],
    );
  }
}
