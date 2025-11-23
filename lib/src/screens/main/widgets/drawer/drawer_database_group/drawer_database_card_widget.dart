import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';

import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';

import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_group/database_delete_dialog_widget.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

class DrawerDatabaseCardWidget extends StatefulWidget {
  const DrawerDatabaseCardWidget({super.key, required this.database});

  final DatabaseModel database;

  @override
  State<DrawerDatabaseCardWidget> createState() =>
      _DrawerDatabaseCardWidgetState();
}

class _DrawerDatabaseCardWidgetState extends State<DrawerDatabaseCardWidget> {
  late bool _isFavorite = widget.database.isFavorite;

  void _selectDatabase() {
    final commands = context.read<SqlCommandsNotifier>();

    commands.activeDatabase = widget.database.label;
    commands.clearResult();

    context.read<MainScreenNotifier>().changeScreen(0);
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

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DatabaseDeleteDialogWidget(onDeleteDatabase: _onDeleteDatabase);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final commands = context.watch<SqlCommandsNotifier>();
    final isActive = commands.activeDatabase == widget.database.label;

    final borderRadius = BorderRadius.circular(10.0);
    final activeColor = Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: InkWell(
        onTap: _selectDatabase,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.grey.shade300.withAlpha(30) : Colors.white,
            borderRadius: borderRadius,
            border: Border.all(
              color: isActive
                  ? activeColor.withAlpha(40)
                  : Colors.grey.shade200,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              top: 2.0,
              bottom: 2.0,
              left: 16.0,
            ),
            leading: Icon(
              Icons.storage_rounded,
              color: isActive ? activeColor : Colors.grey.shade600,
            ),
            title: Text(
              widget.database.label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isActive ? activeColor : Colors.grey.shade800,
              ),
            ),
            subtitle: Text(
              widget.database.name,
              style: TextStyle(
                fontSize: 12.0,
                color: isActive ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
            trailing: PopupMenuButtonWidget(
              items: [
                PopupMenuItem(
                  onTap: _onToggleFavorite,
                  child: Text(
                    _isFavorite
                        ? appLocalizations.unfavorite
                        : appLocalizations.favorite,
                  ),
                ),
                PopupMenuItem(
                  onTap: _showDeleteDialog,
                  child: Text(
                    appLocalizations.delete,
                    style: const TextStyle(color: Colors.redAccent),
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
