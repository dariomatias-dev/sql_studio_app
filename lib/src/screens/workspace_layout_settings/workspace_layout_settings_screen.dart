import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/result.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';

import 'package:sql_studio/src/notifiers/workspace_layout_notifier.dart';

import 'package:sql_studio/src/screens/workspace_layout_settings/widgets/workspace_layout_settings_option_card_widget.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

/// Screen where the user chooses and previews the workspace layout.
class WorkspaceLayoutSettingsScreen extends StatefulWidget {
  /// Creates the workspace layout settings screen.
  const WorkspaceLayoutSettingsScreen({super.key});

  @override
  State<WorkspaceLayoutSettingsScreen> createState() =>
      _WorkspaceLayoutConfigurationScreenState();
}

class _WorkspaceLayoutConfigurationScreenState
    extends State<WorkspaceLayoutSettingsScreen> {
  Future<void> _onHandleLayoutChange(WorkspaceLayoutType layout) async {
    final workspaceLayoutNotifier = context.read<WorkspaceLayoutNotifier>();

    if (workspaceLayoutNotifier.selectedLayout == layout) return;

    final result = await workspaceLayoutNotifier.setLayout(layout);

    if (!mounted) return;

    final appLocalizations = AppLocalizations.of(context)!;

    if (result is FailureResult) {
      await handleError(
        context,
        FailureResult<void>(AppFailure(result.error.type)),
      );
    } else {
      unawaited(Fluttertoast.showToast(msg: appLocalizations.layoutSaved));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Consumer<WorkspaceLayoutNotifier>(
      builder: (context, notifier, _) {
        final selectedLayout = notifier.selectedLayout;

        return ScaffoldWidget(
          appBar: AppBar(title: Text(appLocalizations.workspaceLayout)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                WorkspaceLayoutSettingsOptionCardWidget(
                  icon: Icons.view_agenda_outlined,
                  title: appLocalizations.splitLayout,
                  subtitle: appLocalizations.splitLayoutSubtitle,
                  selected: selectedLayout == WorkspaceLayoutType.split,
                  onTap: () => _onHandleLayoutChange(WorkspaceLayoutType.split),
                ),
                const SizedBox(height: 8),
                WorkspaceLayoutSettingsOptionCardWidget(
                  icon: Icons.tab,
                  title: appLocalizations.tabsLayout,
                  subtitle: appLocalizations.tabsLayoutSubtitle,
                  selected: selectedLayout == WorkspaceLayoutType.tabs,
                  onTap: () => _onHandleLayoutChange(WorkspaceLayoutType.tabs),
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    appLocalizations.preview,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
