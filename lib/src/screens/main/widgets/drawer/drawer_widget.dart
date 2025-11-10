import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/database_notifier.dart';

import 'package:sql_studio/src/screens/main/widgets/drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_group_widget.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _searchController = TextEditingController();

  void _showCreateDatabaseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDatabaseDialogWidget();
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
            backgroundColor: const Color(0xFFF8F9FB),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
                  child: InputWidget(
                    hintText: 'Search databases',
                    controller: _searchController,
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
                              DatabaseGroupWidget(
                                title: 'Favorites',
                                databases: notifier.favorites,
                              ),
                              DatabaseGroupWidget(
                                title: 'All Databases',
                                databases: notifier.others,
                              ),
                            ],
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ButtonWidget(
                    onPressed: _showCreateDatabaseDialog,
                    text: 'New Database',
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
