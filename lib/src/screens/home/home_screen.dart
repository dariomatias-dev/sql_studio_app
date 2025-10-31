import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SqlWorkspaceWidget(),
    );
  }
}
