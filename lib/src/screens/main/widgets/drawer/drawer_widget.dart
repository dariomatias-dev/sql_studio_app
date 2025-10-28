import 'package:flutter/material.dart';

import 'package:sql_studio/src/screens/main/widgets/create_database_dialog_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_list_tile_widget.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

final _databases = <DatabaseModel>[
  DatabaseModel(
    label: 'Favorite Database 1',
    name: 'favorite_database_1',
    isFavorite: true,
  ),
  DatabaseModel(
    label: 'Favorite Database 2',
    name: 'favorite_database_2',
    isFavorite: true,
  ),
  DatabaseModel(
    label: 'Favorite Database 3',
    name: 'favorite_database_3',
    isFavorite: true,
  ),
  DatabaseModel(label: 'All Databases 1', name: 'all_database_1'),
  DatabaseModel(label: 'All Databases 2', name: 'all_database_2'),
  DatabaseModel(label: 'All Databases 3', name: 'all_database_3'),
  DatabaseModel(label: 'All Databases 4', name: 'all_database_4'),
  DatabaseModel(label: 'All Databases 5', name: 'all_database_5'),
  DatabaseModel(label: 'All Databases 6', name: 'all_database_6'),
  DatabaseModel(label: 'All Databases 7', name: 'all_database_7'),
  DatabaseModel(label: 'All Databases 8', name: 'all_database_8'),
];

class DatabaseGroupWidget extends StatelessWidget {
  const DatabaseGroupWidget({
    super.key,
    required this.title,
    required this.databases,
  });

  final String title;
  final List<DatabaseModel> databases;

  @override
  Widget build(BuildContext context) {
    if (databases.isEmpty) return const SizedBox.shrink();

    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: databases
                  .map(
                    (database) =>
                        DrawerDatabaseListTileWidget(database: database),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _searchController = TextEditingController();
  String _filter = '';

  void _showCreateDatabaseDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateDatabaseDialogWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDatabases = _databases
        .where((db) => db.name.toLowerCase().contains(_filter.toLowerCase()))
        .toList();

    final favorites = filteredDatabases.where((db) => db.isFavorite).toList();
    final allDatabases = filteredDatabases
        .where((db) => !db.isFavorite)
        .toList();

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
                onChanged: (value) {
                  setState(() {
                    _filter = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  DatabaseGroupWidget(title: 'Favorites', databases: favorites),
                  SizedBox(height: 20.0),
                  DatabaseGroupWidget(
                    title: 'All Databases',
                    databases: allDatabases,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
              child: ButtonWidget(
                onPressed: _showCreateDatabaseDialog,
                text: 'Create New Database',
                backgroundColor: Colors.grey.shade100,
                borderColor: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
