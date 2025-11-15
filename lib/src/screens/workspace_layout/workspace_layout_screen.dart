import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/notifiers/workspace_layout_notifier.dart';

import 'package:sql_studio/src/screens/workspace_layout/widgets/workspace_layout_option_card_widget.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

class WorkspaceLayoutScreen extends StatefulWidget {
  const WorkspaceLayoutScreen({super.key});

  @override
  State<WorkspaceLayoutScreen> createState() => _WorkspaceLayoutScreenState();
}

class _WorkspaceLayoutScreenState extends State<WorkspaceLayoutScreen> {
  Future<void> _onHandleLayoutChange(WorkspaceLayoutType layout) async {
    final workspaceLayoutNotifier = context.read<WorkspaceLayoutNotifier>();

    if (workspaceLayoutNotifier.selectedLayout == layout) return;

    final result = await workspaceLayoutNotifier.setLayout(layout);

    if (!mounted) return;

    if (result is FailureResult) {
      await handleError(context, result);
    } else {
      Fluttertoast.showToast(msg: 'Layout saved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkspaceLayoutNotifier>(
      builder: (context, notifier, _) {
        final selectedLayout = notifier.selectedLayout;

        return ScaffoldWidget(
          appBar: AppBar(title: const Text('Workspace Layout')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                WorkspaceLayoutOptionCardWidget(
                  icon: Icons.view_agenda_outlined,
                  title: 'Split Layout',
                  subtitle: 'Editor above and console below.',
                  selected: selectedLayout == WorkspaceLayoutType.split,
                  onTap: () => _onHandleLayoutChange(WorkspaceLayoutType.split),
                ),
                const SizedBox(height: 8.0),
                WorkspaceLayoutOptionCardWidget(
                  icon: Icons.tab,
                  title: 'Tabs Layout',
                  subtitle: 'Editor and console in tabs.',
                  selected: selectedLayout == WorkspaceLayoutType.tabs,
                  onTap: () => _onHandleLayoutChange(WorkspaceLayoutType.tabs),
                ),
                const SizedBox(height: 28.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
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
