import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

class DatabasesScreen extends StatelessWidget {
  const DatabasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: defaultDatabases.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
          itemBuilder: (context, index) {
            final db = defaultDatabases[index];

            return CardWidget(
              onTap: () {
                context.read<SqlCommandsNotifier>().activeDatabase = db.name;
                context.read<MainScreenNotifier>().changeScreen(0);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (db.description.isNotEmpty) ...<Widget>[
                            const SizedBox(height: 4.0),
                            Text(
                              db.description,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
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
                    PopupMenuButtonWidget(
                      items: <PopupMenuItem>[
                        PopupMenuItem(
                          onTap: () {},
                          child: const Text('Copy Schemas'),
                        ),
                        PopupMenuItem(
                          onTap: () {},
                          child: const Text('Copy Seeds'),
                        ),
                        PopupMenuItem(
                          onTap: () {},
                          child: const Text('Copy All'),
                        ),
                      ],
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
