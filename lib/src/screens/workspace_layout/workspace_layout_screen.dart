import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/screens/workspace_layout/widgets/workspace_layout_option_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

enum LayoutType { split, tabs }

class WorkspaceLayoutScreen extends StatefulWidget {
  const WorkspaceLayoutScreen({super.key});

  @override
  State<WorkspaceLayoutScreen> createState() => _WorkspaceLayoutScreenState();
}

class _WorkspaceLayoutScreenState extends State<WorkspaceLayoutScreen> {
  LayoutType selectedLayout = LayoutType.split;

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
          ),
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
              selected: selectedLayout == LayoutType.split,
              onTap: () => setState(() => selectedLayout = LayoutType.split),
            ),
            const SizedBox(height: 8.0),
            WorkspaceLayoutOptionCardWidget(
              icon: Icons.tab,
              title: 'Tabs Layout',
              subtitle: 'Editor and console in tabs.',
              selected: selectedLayout == LayoutType.tabs,
              onTap: () => setState(() => selectedLayout = LayoutType.tabs),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: selectedLayout == LayoutType.split
                  ? const Center(
                      child: Text(
                        'Preview',
                        style: TextStyle(color: Colors.black87),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Preview',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
            ),
            const SizedBox(height: 16.0),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  onPressed: context.pop,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  style: ButtonStyleType.black,
                  text: 'Save Layout',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
