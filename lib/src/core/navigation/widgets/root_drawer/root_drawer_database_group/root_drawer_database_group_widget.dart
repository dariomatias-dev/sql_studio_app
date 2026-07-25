import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_card_widget.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';

/// Titled section of the drawer listing a group of databases (e.g.
/// favorites or all databases).
class RootDrawerDatabaseGroupWidget extends StatelessWidget {
  /// Creates a database group section with the given [title] and
  /// [databases].
  const RootDrawerDatabaseGroupWidget({
    required this.title,
    required this.databases,
    super.key,
  });

  /// Heading shown above the group's database list.
  final String title;

  /// Databases displayed in this group.
  final List<DatabaseModel> databases;

  @override
  Widget build(BuildContext context) {
    if (databases.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Row(
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.controlInactive,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(height: 1, color: AppColors.border),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: databases.length,
          itemBuilder: (context, index) {
            return RootDrawerDatabaseCardWidget(database: databases[index]);
          },
        ),
      ],
    );
  }
}
