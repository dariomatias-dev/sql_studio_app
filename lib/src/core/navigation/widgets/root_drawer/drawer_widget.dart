import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/database_notifier.dart';

import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_group_widget.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

class RootDrawerWidget extends StatefulWidget {
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
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Consumer<DatabaseNotifier>(
      builder:
          (BuildContext context, DatabaseNotifier notifier, Widget? child) {
            return Drawer(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20.0,
                        24.0,
                        20.0,
                        16.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.auto_awesome_mosaic_rounded,
                            size: 24.0,
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            l10n.databases.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  size: 18.0,
                                ),
                              )
                            : const Icon(Icons.search_rounded, size: 18.0),
                        onChanged: notifier.setFilter,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Expanded(
                      child: notifier.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2.0,
                              ),
                            )
                          : ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                RootDrawerDatabaseGroupWidget(
                                  title: l10n.favorites,
                                  databases: notifier.favorites,
                                ),
                                const SizedBox(height: 12.0),
                                RootDrawerDatabaseGroupWidget(
                                  title: l10n.allDatabases,
                                  databases: notifier.others,
                                ),
                                const SizedBox(height: 100.0),
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ButtonWidget(
                        onPressed: () =>
                            CreateDatabaseDialogWidget.show(context),
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
