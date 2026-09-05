import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/types/workspace_layout_type.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/widgets/workspace_layout_settings_option_card_widget.dart';
import 'package:sql_studio/src/features/workspace_layout_settings/presentation/workspace_layout_providers.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

/// Screen where the user chooses and previews the workspace layout.
class WorkspaceLayoutSettingsScreen extends ConsumerStatefulWidget {
  /// Creates the workspace layout settings screen.
  const WorkspaceLayoutSettingsScreen({super.key});

  @override
  ConsumerState<WorkspaceLayoutSettingsScreen> createState() =>
      _WorkspaceLayoutConfigurationScreenState();
}

class _WorkspaceLayoutConfigurationScreenState
    extends ConsumerState<WorkspaceLayoutSettingsScreen> {
  Future<void> _onHandleLayoutChange(WorkspaceLayoutType layout) async {
    final viewModel = ref.read(workspaceLayoutViewModelProvider.notifier);

    if (ref.read(workspaceLayoutViewModelProvider) == layout) return;

    final result = await viewModel.setLayout(layout);

    if (!mounted) return;

    final appLocalizations = AppLocalizations.of(context)!;

    switch (result) {
      case FailureResult(:final error):
        await handleError(
          context,
          FailureResult<void>(AppFailure(error.type)),
        );
      case SuccessResult():
        unawaited(AppToast.of(context).show(appLocalizations.layoutSaved));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final selectedLayout = ref.watch(workspaceLayoutViewModelProvider);

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
                appLocalizations.preview.toUpperCase(),
                style: TextStyle(
                  color: context.colors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.white,
                    border: Border.fromBorderSide(
                      BorderSide(color: context.colors.border),
                    ),
                  ),
                  child: const SqlWorkspaceWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
