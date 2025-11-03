import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/sql_commands.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

class SqlCommandBarWidget extends StatelessWidget {
  const SqlCommandBarWidget({super.key, required this.onInsertCommand});

  final ValueChanged<String> onInsertCommand;

  @override
  Widget build(BuildContext context) {
    final suggestions = context.watch<SqlSuggestionsNotifier>().commands;
    final commands = suggestions.isEmpty ? sqlCommands : suggestions;

    return Container(
      height: 52.0,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        scrollDirection: Axis.horizontal,
        itemCount: commands.length,
        itemBuilder: (context, index) {
          final cmd = commands[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 10.0,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () => onInsertCommand(cmd),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  cmd.trim(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
