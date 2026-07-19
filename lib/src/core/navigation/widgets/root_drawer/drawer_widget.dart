import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_group_widget.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

/// App-wide navigation drawer listing favorite and other databases, with
/// search and database creation entry points.
class RootDrawerWidget extends StatefulWidget {
  /// Creates the root drawer.
  const RootDrawerWidget({super.key});

  @override
  State<RootDrawerWidget> createState() => _RootDrawerWidgetState();
}

class _RootDrawerWidgetState extends State<RootDrawerWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<DatabaseNotifier>(
      builder: (context, notifier, child) {
        return Drawer(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    24,
                    20,
                    16,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  child: notifier.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : ListView(
                          physics: const BouncingScrollPhysics(),
                          children: <Widget>[
                            RootDrawerDatabaseGroupWidget(
                              title: l10n.favorites,
                              databases: notifier.favorites,
                            ),
                            const SizedBox(height: 12),
                            RootDrawerDatabaseGroupWidget(
                              title: l10n.allDatabases,
                              databases: notifier.others,
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
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
      },
    );
  }
}
