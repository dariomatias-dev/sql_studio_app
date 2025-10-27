import 'package:flutter/material.dart';

import 'package:sql_studio/src/screen/main/widgets/drawer/drawer_database_list_tile_widget.dart';
import 'package:sql_studio/src/shared/models/database_model.dart';

import 'package:sql_studio/src/shared/widgets/input_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: InputWidget(hintText: 'Search databases'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            DrawerDatabaseListTileWidget(
              database: DatabaseModel(
                label: 'Favorite Database 1',
                name: 'favorite_database_1',
                isFavorite: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'All Databases',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            DrawerDatabaseListTileWidget(
              database: DatabaseModel(label: 'Database 1', name: 'database_1'),
            ),
            DrawerDatabaseListTileWidget(
              database: DatabaseModel(label: 'Database 2', name: 'database_1'),
            ),
          ],
        ),
      ),
    );
  }
}
