import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

class DatabasesScreen extends StatefulWidget {
  const DatabasesScreen({super.key});

  @override
  State<DatabasesScreen> createState() => _DatabasesScreenState();
}

class _DatabasesScreenState extends State<DatabasesScreen> {
  Future<void> _copyFile(List<String> paths, String message) async {
    final contents = await Future.wait(
      paths.map((path) => rootBundle.loadString(path)),
    );

    await Clipboard.setData(ClipboardData(text: contents.join('\n')));

    if (mounted) {
      SnackBarUtils.show(context, message);
    }
  }

  Future<void> _copySchema(String dbName) async {
    await _copyFile(<String>[
      'assets/sql/schemas/${dbName.toLowerCase()}_schema.sql',
    ], 'Schema copied!');
  }

  Future<void> _copySeed(String dbName) async {
    await _copyFile(<String>[
      'assets/sql/seeds/${dbName.toLowerCase()}_seed.sql',
    ], 'Seed copied!');
  }

  Future<void> _copyAll(String dbName) async {
    await _copyFile(<String>[
      'assets/sql/schemas/${dbName.toLowerCase()}_schema.sql',
      'assets/sql/seeds/${dbName.toLowerCase()}_seed.sql',
    ], 'Schema and Seed copied!');
  }

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
            final dbName = db.name;

            return CardWidget(
              onTap: () {
                context.read<SqlCommandsNotifier>().activeDatabase = dbName;
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
                          onTap: () => _copySchema(dbName),
                          child: const Text('Copy Schemas'),
                        ),
                        PopupMenuItem(
                          onTap: () => _copySeed(dbName),
                          child: const Text('Copy Seeds'),
                        ),
                        PopupMenuItem(
                          onTap: () => _copyAll(dbName),
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
