import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

class DatabasesScreen extends StatelessWidget {
  const DatabasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: defaultDatabases.length,
          itemBuilder: (context, index) {
            final db = defaultDatabases[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  context.read<SqlCommandsNotifier>().activeDatabase = db.name;
                  context.read<MainScreenNotifier>().changeScreen(0);
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            db.label,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            db.description,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            '${db.tables.length} tables: ${db.tables.join(', ')}',
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black38,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
