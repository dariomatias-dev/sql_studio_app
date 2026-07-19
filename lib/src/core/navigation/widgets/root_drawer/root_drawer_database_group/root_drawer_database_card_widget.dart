import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/database_delete_dialog_widget.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/navigation_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

/// Drawer list item representing a single database, with actions to
/// select, favorite, and delete it.
class RootDrawerDatabaseCardWidget extends StatefulWidget {
  /// Creates a database card for the given [database].
  const RootDrawerDatabaseCardWidget({required this.database, super.key});

  /// The database this card represents.
  final DatabaseModel database;

  @override
  State<RootDrawerDatabaseCardWidget> createState() =>
      _RootDrawerDatabaseCardWidgetState();
}

class _RootDrawerDatabaseCardWidgetState
    extends State<RootDrawerDatabaseCardWidget> {
  late bool _isFavorite = widget.database.isFavorite;

  void _selectDatabase() {
    context.read<SqlCommandsNotifier>()
      ..activeDatabase = widget.database.label
      ..clearResult();

    context.read<NavigationNotifier>().setIndex(0);
    context.read<SqlEditorNotifier>().focusNode.requestFocus();

    Scaffold.of(context).closeDrawer();
  }

  Future<void> _onDeleteDatabase() async {
    context.pop();

    final result = await context.read<DatabaseNotifier>().delete(
      widget.database,
    );

    if (!mounted) return;

    if (result.isSuccess) {
      final commands = context.read<SqlCommandsNotifier>();
      if (commands.activeDatabase == widget.database.name) {
        commands.activeDatabase = null;

        await SharedPreferencesService.remove(
          SharedPreferencesKeys.selectedDatabaseKey,
        );
      }
    } else {
      await handleError(context, result);
    }
  }

  Future<void> _onToggleFavorite() async {
    setState(() => _isFavorite = !_isFavorite);

    final result = await context.read<DatabaseNotifier>().toggleFavorite(
      widget.database,
    );

    if (mounted) await handleError(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final commands = context.watch<SqlCommandsNotifier>();
    final isActive = commands.activeDatabase == widget.database.label;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: isActive ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: _selectDatabase,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isActive ? Colors.black : const Color(0xFFF0F0F0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.dns_rounded,
                  size: 20,
                  color: isActive ? Colors.white : const Color(0xFF757575),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.database.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isActive ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        widget.database.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isActive
                              ? Colors.white.withAlpha(160)
                              : const Color(0xFFADADAD),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButtonWidget(
                  items: <PopupMenuItem<void>>[
                    PopupMenuItem<void>(
                      onTap: _onToggleFavorite,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            _isFavorite
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Text(_isFavorite ? l10n.unfavorite : l10n.favorite),
                        ],
                      ),
                    ),
                    PopupMenuItem<void>(
                      onTap: () {
                        unawaited(
                          DatabaseDeleteDialogWidget.show(
                            context,
                            onDeleteDatabase: _onDeleteDatabase,
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                            color: Color(0xFFFF3B30),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.delete,
                            style: const TextStyle(color: Color(0xFFFF3B30)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
