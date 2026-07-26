import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/database/default_database_model.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_section_header_widget.dart';

/// Card that presents a default database and its available actions.
class DatabaseCardWidget extends ConsumerStatefulWidget {
  /// Creates a card for the given default database [db].
  const DatabaseCardWidget({required this.db, super.key});

  /// The default database this card represents.
  final DefaultDatabaseModel db;

  @override
  ConsumerState<DatabaseCardWidget> createState() => _DatabaseCardWidgetState();
}

class _DatabaseCardWidgetState extends ConsumerState<DatabaseCardWidget> {
  Future<void> _copyFile(List<String> paths, String message) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final contents = await Future.wait(
      paths.map(rootBundle.loadString),
    );

    await Clipboard.setData(ClipboardData(text: contents.join('\n')));

    if (mounted) {
      unawaited(AppToast.show(message));
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
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.border),
        onTap: () {
          ref.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
              widget.db.name;
          ref.read(navigationViewModelProvider.notifier).index = 0;
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                      ),
                      child: const Icon(
                        Icons.dns_rounded,
                        color: AppColors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            l10n.key(widget.db.labelKey),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'root/${widget.db.name.toLowerCase()}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withAlpha(100),
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButtonWidget(
                      items: <PopupMenuEntry<void>>[
                        PopupMenuSectionHeaderWidget(
                          label: l10n.structureSection,
                        ),
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
                        const PopupMenuDivider(),
                        PopupMenuSectionHeaderWidget(
                          label: l10n.sqlFilesSection,
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
                    color: AppColors.black.withAlpha(180),
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadii.xs),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        '$tableCount',
                        style: const TextStyle(
                          color: AppColors.black,
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
                        color: AppColors.black,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '|',
                        style: TextStyle(color: AppColors.border),
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
                                  color: AppColors.black.withAlpha(120),
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
        Icon(icon, size: 20, color: AppColors.black),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
