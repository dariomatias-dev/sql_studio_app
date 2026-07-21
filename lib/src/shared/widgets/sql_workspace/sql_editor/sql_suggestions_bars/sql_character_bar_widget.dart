import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (int i = 0; i < characters.length; i++) ...<Widget>[
              GestureDetector(
                onTap: () => onInsertCommand(characters[i]),
                child: Container(
                  width: 44,
                  height: 32,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      characters[i],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'monospace',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              if (i < characters.length - 1)
                Container(
                  height: 20,
                  width: 1,
                  color: AppColors.controlInactive,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
