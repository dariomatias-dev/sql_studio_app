import 'dart:async';

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

/// Card that presents a default database and its available actions.
class DatabaseCardWidget extends StatefulWidget {
  /// Creates a card for the given default database [db].
  const DatabaseCardWidget({required this.db, super.key});

  /// The default database this card represents.
  final DefaultDatabaseModel db;

  @override
  State<DatabaseCardWidget> createState() => _DatabaseCardWidgetState();
}

class _DatabaseCardWidgetState extends State<DatabaseCardWidget> {
  Future<void> _copyFile(List<String> paths, String message) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final contents = await Future.wait(
      paths.map(rootBundle.loadString),
    );

    await Clipboard.setData(ClipboardData(text: contents.join('\n')));

    if (mounted) {
      unawaited(
        Fluttertoast.showToast(
          msg: message,
          backgroundColor: const Color(0xFF111111),
          textColor: Colors.white,
          fontSize: 14,
        ),
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
    final l10n = AppLocalizations.of(context)!;
    final tableCount = widget.db.tables.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: CardWidget(
        onTap: () {
          context.read<SqlCommandsNotifier>().activeDatabase = widget.db.name;
          context.read<NavigationNotifier>().setIndex(0);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 12, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.dns_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              l10n.key(widget.db.labelKey),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'root/${widget.db.name.toLowerCase()}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withAlpha(100),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButtonWidget(
                        items: <PopupMenuItem<void>>[
                          PopupMenuItem<void>(
                            onTap: () => AppRoutes.goToDatabaseVisualizer(
                              context,
                              dbName: widget.db.name,
                            ),
                            child: _MenuAction(
                              icon: Icons.account_tree_outlined,
                              label: l10n.viewStructure,
                            ),
                          ),
                          PopupMenuItem<void>(
                            onTap: _copySchema,
                            child: _MenuAction(
                              icon: Icons.terminal_rounded,
                              label: l10n.copySchema,
                            ),
                          ),
                          PopupMenuItem<void>(
                            onTap: _copySeed,
                            child: _MenuAction(
                              icon: Icons.data_object_outlined,
                              label: l10n.copySeed,
                            ),
                          ),
                          PopupMenuItem<void>(
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    l10n.key(widget.db.descriptionKey),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withAlpha(180),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    border: Border(
                      top: BorderSide(
                        color: Colors.black.withAlpha(15),
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$tableCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.tables.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '|',
                          style: TextStyle(color: Color(0xFFE0E0E0)),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.db.tables.map((table) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  table,
                                  style: TextStyle(
                                    fontSize: 12,
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
  const _MenuAction({
    required this.icon,
    required this.label,
    this.isBold = false,
  });
  final IconData icon;
  final String label;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 20, color: Colors.black),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
