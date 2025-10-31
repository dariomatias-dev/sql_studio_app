import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

class DefaultDatabaseScreen extends StatelessWidget {
  const DefaultDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
            size: 20.0,
          ),
          onPressed: context.pop,
        ),
      ),
      body: const SqlWorkspaceWidget(),
    );
  }
}
