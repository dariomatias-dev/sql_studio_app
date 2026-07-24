import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

/// The application's home screen, hosting the SQL workspace.
class HomeScreen extends StatefulWidget {
  /// Creates the home screen.
  const HomeScreen({super.key, this.navBarInset = 0});

  /// Space taken by the floating bottom nav bar, so the workspace's
  /// scrollable content (not its background) can clear it.
  final double navBarInset;

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

    return ScaffoldWidget(
      showExitButton: false,
      body: Padding(
        padding: EdgeInsets.only(bottom: widget.navBarInset),
        child: const SqlWorkspaceWidget(),
      ),
    );
  }
}
