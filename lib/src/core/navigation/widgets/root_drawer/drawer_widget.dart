import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_durations.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_group_widget.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/loading_state_widget.dart';

/// App-wide navigation drawer listing favorite and other databases, with
/// search and database creation entry points.
class RootDrawerWidget extends ConsumerStatefulWidget {
  /// Creates the root drawer.
  const RootDrawerWidget({super.key});

  @override
  ConsumerState<RootDrawerWidget> createState() => _RootDrawerWidgetState();
}

class _RootDrawerWidgetState extends ConsumerState<RootDrawerWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(databaseListViewModelProvider);
    final notifier = ref.read(databaseListViewModelProvider.notifier);

    return Drawer(
      backgroundColor: context.colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colors.border),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                AppSpacing.lg,
                20,
                AppSpacing.md,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.auto_awesome_mosaic_rounded,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.databases.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: InputWidget(
                controller: _searchController,
                hintText: l10n.searchDatabases,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          notifier.setFilter('');
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 18,
                        ),
                      )
                    : const Icon(Icons.search_rounded, size: 18),
                onChanged: notifier.setFilter,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppDurations.sm,
                child: state.isLoading
                    ? const LoadingStateWidget(
                        key: ValueKey('drawer_loading'),
                        size: 24,
                      )
                    : state.favorites.isEmpty &&
                          state.others.isEmpty &&
                          _searchController.text.isEmpty
                    ? EmptyStateWidget(
                        key: const ValueKey('drawer_empty'),
                        message: l10n.noDatabasesYet,
                        icon: Icons.dns_outlined,
                      )
                    : ListView(
                        key: const ValueKey('drawer_list'),
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          RootDrawerDatabaseGroupWidget(
                            title: l10n.favorites,
                            databases: state.favorites,
                          ),
                          const SizedBox(height: 12),
                          RootDrawerDatabaseGroupWidget(
                            title: l10n.allDatabases,
                            databases: state.others,
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ButtonWidget(
                onPressed: () => CreateDatabaseDialogWidget.show(context),
                text: l10n.newDatabase,
                width: double.infinity,
                style: ButtonStyleType.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
