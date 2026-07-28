import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';

import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';

/// Screen that lists the available default databases.
class DatabasesScreen extends StatefulWidget {
  /// Creates the databases screen.
  const DatabasesScreen({super.key});

  @override
  State<DatabasesScreen> createState() => _DatabasesScreenState();
}

class _DatabasesScreenState extends State<DatabasesScreen>
    with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();
  var _filter = '';

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
    final query = _filter.trim().toLowerCase();
    final databases = query.isEmpty
        ? defaultDatabases
        : defaultDatabases
              .where(
                (db) => l10n.key(db.labelKey).toLowerCase().contains(query),
              )
              .toList();

    return ScaffoldWidget(
      showExitButton: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            InputWidget(
              controller: _searchController,
              hintText: l10n.searchDatabases,
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _filter = '');
                      },
                      icon: const Icon(Icons.close_rounded, size: 18),
                    )
                  : const Icon(Icons.search_rounded, size: 18),
              onChanged: (value) => setState(() => _filter = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: databases.isEmpty
                  ? EmptyStateWidget(
                      message: l10n.noDatabasesFound,
                      icon: Icons.search_off_rounded,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 16),
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
