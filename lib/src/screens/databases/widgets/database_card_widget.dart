import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';
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
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
      );
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
    final tableCount = widget.db.tables.length;

    return CardWidget(
      onTap: () {
        context.read<SqlCommandsNotifier>().activeDatabase = widget.db.name;
        context.read<NavigationNotifier>().setIndex(0);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withAlpha(26)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.white, Colors.grey.shade50],
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        appLocalizations.key(widget.db.labelKey),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withAlpha(26),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.table_chart_outlined,
                              size: 12.0,
                              color: Colors.blueGrey.shade700,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '$tableCount',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    appLocalizations.key(widget.db.descriptionKey),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13.0,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '${appLocalizations.tables}: ${widget.db.tables.join(', ')}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButtonWidget(
              items: <PopupMenuItem>[
                PopupMenuItem(
                  onTap: () {
                    AppRoutes.goToDatabaseVisualizer(
                      context,
                      dbName: widget.db.name,
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.schema_outlined,
                        size: 20.0,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 12.0),
                      Text(appLocalizations.viewStructure),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: _copySchema,
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.code, size: 20.0, color: Colors.black54),
                      const SizedBox(width: 12.0),
                      Text(appLocalizations.copySchema),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: _copySeed,
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.data_array,
                        size: 20.0,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 12.0),
                      Text(appLocalizations.copySeed),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: _copyAll,
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.copy_all,
                        size: 20.0,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 12.0),
                      Text(appLocalizations.copyAll),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
