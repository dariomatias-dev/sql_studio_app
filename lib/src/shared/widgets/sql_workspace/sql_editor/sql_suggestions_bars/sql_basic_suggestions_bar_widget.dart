import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/sql_commands.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

class SqlBasicSuggestionsBarWidget extends StatelessWidget {
  const SqlBasicSuggestionsBarWidget({
    super.key,
    required this.onInsertCommand,
  });

  final ValueChanged<String> onInsertCommand;

  @override
  Widget build(BuildContext context) {
    final suggestions = context.watch<SqlSuggestionsNotifier>().commands;
    final commands = suggestions.isEmpty ? sqlCommands : suggestions;

    return SqlSuggestionsBarBaseWidget(
      onTap: (index) {
        onInsertCommand(commands[index]);
      },
      itemCount: commands.length,
      itemBuilder: (index) => commands[index],
    );
  }
}
