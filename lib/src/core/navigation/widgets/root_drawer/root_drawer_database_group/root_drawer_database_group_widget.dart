import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_card_widget.dart';
import 'package:sql_studio/src/shared/models/database_model.dart';

class RootDrawerDatabaseGroupWidget extends StatelessWidget {
  final String title;
  final List<DatabaseModel> databases;

  const RootDrawerDatabaseGroupWidget({
    super.key,
    required this.title,
    required this.databases,
  });

  @override
  Widget build(BuildContext context) {
    if (databases.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
          child: Row(
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFADADAD),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(height: 1.0, color: const Color(0xFFF0F0F0)),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemCount: databases.length,
          itemBuilder: (BuildContext context, int index) {
            return RootDrawerDatabaseCardWidget(database: databases[index]);
          },
        ),
      ],
    );
  }
}
