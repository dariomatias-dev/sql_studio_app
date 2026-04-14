import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScaffoldWidget(showExitButton: false, body: SqlWorkspaceWidget());
  }
}
