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
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Consumer<DatabaseNotifier>(
      builder: (context, notifier, child) {
        return SafeArea(
          child: Drawer(
            backgroundColor: const Color(0xFFF8F9FB),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
                  child: InputWidget(
                    controller: _searchController,
                    hintText: appLocalizations.searchDatabases,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.text = '';

                        notifier.setFilter('');
                      },
                      icon: Icon(Icons.close),
                    ),
                    onChanged: notifier.setFilter,
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: notifier.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            spacing: 24.0,
                            children: <Widget>[
                              RootDrawerDatabaseGroupWidget(
                                title: appLocalizations.favorites,
                                databases: notifier.favorites,
                              ),
                              RootDrawerDatabaseGroupWidget(
                                title: appLocalizations.allDatabases,
                                databases: notifier.others,
                              ),
                            ],
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ButtonWidget(
                    onPressed: () => CreateDatabaseDialogWidget.show(context),
                    text: appLocalizations.newDatabase,
                    backgroundColor: Colors.grey.shade100,
                    borderColor: Colors.grey.shade200,
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
