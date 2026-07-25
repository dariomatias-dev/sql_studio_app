import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';

import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

/// Screen that lists the available default databases.
class DatabasesScreen extends StatefulWidget {
  /// Creates the databases screen.
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
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 64),
          itemCount: defaultDatabases.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return DatabaseCardWidget(db: defaultDatabases[index]);
          },
        ),
      ),
    );
  }
}
