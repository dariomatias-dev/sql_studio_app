import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/models/default_database_model.dart';
import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

class DatabaseCardWidget extends StatefulWidget {
  const DatabaseCardWidget({super.key, required this.db});

  final DefaultDatabaseModel db;

  @override
  State<DatabaseCardWidget> createState() => _DatabaseCardWidgetState();
}

class _DatabaseCardWidgetState extends State<DatabaseCardWidget> {
  Future<void> _copyFile(List<String> paths, String message) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final contents = await Future.wait(
      paths.map((path) => rootBundle.loadString(path)),
    );

    await Clipboard.setData(ClipboardData(text: contents.join('\n')));

    if (mounted) {
      SnackBarUtils.show(context, message);
    }
  }

  Future<void> _copySchema() async {
    await _copyFile(<String>[
      'assets/sql/schemas/${widget.db.name.toLowerCase()}_schema.sql',
    ], 'Schema copied!');
  }

  Future<void> _copySeed() async {
    await _copyFile(<String>[
      'assets/sql/seeds/${widget.db.name.toLowerCase()}_seed.sql',
    ], 'Seed copied!');
  }

  Future<void> _copyAll() async {
    await _copyFile(<String>[
      'assets/sql/schemas/${widget.db.name.toLowerCase()}_schema.sql',
      'assets/sql/seeds/${widget.db.name.toLowerCase()}_seed.sql',
    ], 'Schema and Seed copied!');
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: () {
        context.read<SqlCommandsNotifier>().activeDatabase = widget.db.name;
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
                    widget.db.label,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.db.description.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 4.0),
                    Text(
                      widget.db.description,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6.0),
                  Text(
                    '${widget.db.tables.length} tables: ${widget.db.tables.join(', ')}',
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
                  onTap: _copySchema,
                  child: const Text('Copy Schemas'),
                ),
                PopupMenuItem(
                  onTap: _copySeed,
                  child: const Text('Copy Seeds'),
                ),
                PopupMenuItem(onTap: _copyAll, child: const Text('Copy All')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
