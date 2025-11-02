import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Exit Screen',
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
            size: 20.0,
          ),
        ),
      ),
      body: SafeArea(child: const SqlWorkspaceWidget()),
    );
  }
}
