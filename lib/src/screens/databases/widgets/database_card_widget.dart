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

    final List<String> contents = await Future.wait(
      paths.map((String path) => rootBundle.loadString(path)),
    );

    await Clipboard.setData(ClipboardData(text: contents.join('\n')));

    if (mounted) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFF111111),
        textColor: Colors.white,
        fontSize: 14.0,
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
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final int tableCount = widget.db.tables.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: CardWidget(
        onTap: () {
          context.read<SqlCommandsNotifier>().activeDatabase = widget.db.name;
          context.read<NavigationNotifier>().setIndex(0);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 30.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 12.0, 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 54.0,
                        width: 54.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: const Icon(
                          Icons.dns_rounded,
                          color: Colors.white,
                          size: 26.0,
                        ),
                      ),
                      const SizedBox(width: 18.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              l10n.key(widget.db.labelKey),
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'root/${widget.db.name.toLowerCase()}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withAlpha(100),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButtonWidget(
                        items: <PopupMenuItem>[
                          PopupMenuItem(
                            onTap: () => AppRoutes.goToDatabaseVisualizer(
                              context,
                              dbName: widget.db.name,
                            ),
                            child: _MenuAction(
                              icon: Icons.account_tree_outlined,
                              label: l10n.viewStructure,
                            ),
                          ),
                          PopupMenuItem(
                            onTap: _copySchema,
                            child: _MenuAction(
                              icon: Icons.terminal_rounded,
                              label: l10n.copySchema,
                            ),
                          ),
                          PopupMenuItem(
                            onTap: _copySeed,
                            child: _MenuAction(
                              icon: Icons.data_object_outlined,
                              label: l10n.copySeed,
                            ),
                          ),
                          PopupMenuItem(
                            onTap: _copyAll,
                            child: _MenuAction(
                              icon: Icons.auto_awesome_rounded,
                              label: l10n.copyAll,
                              isBold: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    l10n.key(widget.db.descriptionKey),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black.withAlpha(180),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 28.0),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    border: Border(
                      top: BorderSide(
                        color: Colors.black.withAlpha(15),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '$tableCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        l10n.tables.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          color: Colors.black,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          '|',
                          style: TextStyle(color: Color(0xFFE0E0E0)),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.db.tables.map((String table) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  table,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withAlpha(120),
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isBold;

  const _MenuAction({
    required this.icon,
    required this.label,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 20.0, color: Colors.black),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
