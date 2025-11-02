import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/notifiers/workspace_layout_notifier.dart';
import 'package:sql_studio/src/screens/workspace_layout/widgets/workspace_layout_option_card_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

class WorkspaceLayoutScreen extends StatelessWidget {
  const WorkspaceLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkspaceLayoutNotifier>(
      builder: (context, notifier, _) {
        final selectedLayout = notifier.selectedLayout;
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
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
            title: const Text(
              'Workspace Layout',
              style: TextStyle(color: Colors.black87, fontSize: 20.0),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                WorkspaceLayoutOptionCardWidget(
                  icon: Icons.view_agenda_outlined,
                  title: 'Split Layout',
                  subtitle: 'Editor above and console below.',
                  selected: selectedLayout == WorkspaceLayoutType.split,
                  onTap: () => notifier.setLayout(WorkspaceLayoutType.split),
                ),
                const SizedBox(height: 8.0),
                WorkspaceLayoutOptionCardWidget(
                  icon: Icons.tab,
                  title: 'Tabs Layout',
                  subtitle: 'Editor and console in tabs.',
                  selected: selectedLayout == WorkspaceLayoutType.tabs,
                  onTap: () => notifier.setLayout(WorkspaceLayoutType.tabs),
                ),
                const SizedBox(height: 28.0),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: const Text(
                    'Preview:',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const SqlWorkspaceWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
