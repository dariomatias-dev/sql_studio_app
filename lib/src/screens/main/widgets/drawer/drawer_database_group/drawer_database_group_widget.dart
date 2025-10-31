import 'package:flutter/material.dart';

import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';

class DatabaseGroupWidget extends StatelessWidget {
  const DatabaseGroupWidget({
    super.key,
    required this.title,
    required this.databases,
    required this.toggleFavorite,
    required this.onDelete,
  });

  final String title;
  final List<DatabaseModel> databases;
  final Future<void> Function(DatabaseModel database) toggleFavorite;
  final Future<void> Function(DatabaseModel database) onDelete;

  @override
  Widget build(BuildContext context) {
    if (databases.isEmpty) return const SizedBox.shrink();

    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: databases.length,
          itemBuilder: (context, index) {
            final database = databases[index];

            return DrawerDatabaseListTileWidget(
              database: database,
              toggleFavorite: () async => await toggleFavorite(database),
              onDelete: () async => await onDelete(database),
            );
          },
        ),
      ],
    );
  }
}
