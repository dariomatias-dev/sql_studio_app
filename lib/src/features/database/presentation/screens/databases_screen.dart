import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';

/// Screen that lists the available default databases.
class DatabasesScreen extends ConsumerStatefulWidget {
  /// Creates the databases screen.
  const DatabasesScreen({super.key});

  @override
  ConsumerState<DatabasesScreen> createState() => _DatabasesScreenState();
}

class _DatabasesScreenState extends ConsumerState<DatabasesScreen>
    with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final l10n = AppLocalizations.of(context)!;
    final viewModel = ref.read(defaultDatabasesViewModelProvider.notifier);

    ref.watch(defaultDatabasesViewModelProvider);

    final databases = viewModel.filtered(l10n.key);

    return ScaffoldWidget(
      showExitButton: false,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: <Widget>[
            InputWidget(
              controller: _searchController,
              hintText: l10n.searchDatabases,
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        viewModel.setFilter('');
                      },
                      icon: const Icon(Icons.close_rounded, size: 18),
                    )
                  : const Icon(Icons.search_rounded, size: 18),
              onChanged: viewModel.setFilter,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: databases.isEmpty
                  ? EmptyStateWidget(
                      message: l10n.noDatabasesFound,
                      icon: Icons.search_off_rounded,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      itemCount: databases.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return DatabaseCardWidget(db: databases[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
