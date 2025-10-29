import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/screens/main/widgets/create_database_dialog_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_group_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

import 'package:sql_studio/src/notifiers/database_notifier.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _searchController = TextEditingController();

  void _showCreateDatabaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDatabaseDialogWidget(
          onCreated: (database) async {
            await context.read<DatabaseNotifier>().create(database);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseNotifier>(
      builder: (context, notifier, child) {
        return SafeArea(
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InputWidget(
                    hintText: 'Search databases',
                    controller: _searchController,
                    onChanged: notifier.setFilter,
                  ),
                ),
                Expanded(
                  child: notifier.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              DatabaseGroupWidget(
                                title: 'Favorites',
                                databases: notifier.favorites,
                                toggleFavorite: notifier.toggleFavorite,
                                onDelete: notifier.delete,
                              ),
                              const SizedBox(height: 20.0),
                              DatabaseGroupWidget(
                                title: 'All Databases',
                                databases: notifier.others,
                                toggleFavorite: notifier.toggleFavorite,
                                onDelete: notifier.delete,
                              ),
                            ],
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                  child: ButtonWidget(
                    onPressed: () => _showCreateDatabaseDialog(context),
                    text: 'Create New Database',
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
