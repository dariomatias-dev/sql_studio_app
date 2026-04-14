import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';

import 'package:sql_studio/src/screens/databases/widgets/database_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class DatabasesScreen extends StatefulWidget {
  const DatabasesScreen({super.key});

  @override
  State<DatabasesScreen> createState() => _DatabasesScreenState();
}

class _DatabasesScreenState extends State<DatabasesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScaffoldWidget(
      showExitButton: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: defaultDatabases.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
          itemBuilder: (context, index) {
            return DatabaseCardWidget(db: defaultDatabases[index]);
          },
        ),
      ),
    );
  }
}
