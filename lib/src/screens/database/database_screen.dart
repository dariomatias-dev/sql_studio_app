import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

/// Screen that hosts the SQL workspace for a selected database.
class DatabaseScreen extends StatelessWidget {
  /// Creates the database screen.
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(appBar: AppBar(), body: const SqlWorkspaceWidget());
  }
}
