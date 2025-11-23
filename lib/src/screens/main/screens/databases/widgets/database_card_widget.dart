import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/models/default_database_model.dart';
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
      Fluttertoast.showToast(msg: message);
    }
  }

  Future<void> _copySchema() async {
    await _copyFile(<String>[
      'assets/sql/schemas/${widget.db.name.toLowerCase()}_schema.sql',
    ], AppLocalizations.of(context)!.schemaCopied);
  }

  Future<void> _copySeed() async {
    await _copyFile(<String>[
      'assets/sql/seeds/${widget.db.name.toLowerCase()}_seed.sql',
    ], AppLocalizations.of(context)!.seedCopied);
  }

  Future<void> _copyAll() async {
    await _copyFile(<String>[
      'assets/sql/schemas/${widget.db.name.toLowerCase()}_schema.sql',
      'assets/sql/seeds/${widget.db.name.toLowerCase()}_seed.sql',
    ], AppLocalizations.of(context)!.schemaAndSeedCopied);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

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
                    appLocalizations.key(widget.db.labelKey),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.db.descriptionKey.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 4.0),
                    Text(
                      appLocalizations.key(widget.db.descriptionKey),
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
                  onTap: () {
                    context.push(RouteNames.databaseVisualizer(widget.db.name));
                  },
                  child: Text(appLocalizations.viewStructure),
                ),
                PopupMenuItem(
                  onTap: _copySchema,
                  child: Text(appLocalizations.copySchema),
                ),
                PopupMenuItem(
                  onTap: _copySeed,
                  child: Text(appLocalizations.copySeed),
                ),
                PopupMenuItem(
                  onTap: _copyAll,
                  child: Text(appLocalizations.copyAll),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
