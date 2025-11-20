import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';

import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_group/database_delete_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

class DrawerDatabaseListTileWidget extends StatefulWidget {
  const DrawerDatabaseListTileWidget({super.key, required this.database});

  final DatabaseModel database;

  @override
  State<DrawerDatabaseListTileWidget> createState() =>
      _DrawerDatabaseListTileWidgetState();
}

class _DrawerDatabaseListTileWidgetState
    extends State<DrawerDatabaseListTileWidget> {
  late bool _isFavorite = widget.database.isFavorite;

  void _selectDatabase() {
    final notifier = context.read<SqlCommandsNotifier>();
    final databaseName = widget.database.label;

    notifier.activeDatabase = databaseName;
    notifier.clearResult();

    context.read<MainScreenNotifier>().changeScreen(0);

    context.read<SqlEditorNotifier>().focusNode.requestFocus();

    Scaffold.of(context).closeDrawer();
  }

  void _onToggleFavorite() async {
    setState(() => _isFavorite = !_isFavorite);

    final result = await context.read<DatabaseNotifier>().toggleFavorite(
      widget.database,
    );

    if (!mounted) return;

    await handleError(context, result);
  }

  Future<void> _onDeleteDatabase() async {
    context.pop(context);

    final result = await context.read<DatabaseNotifier>().delete(
      widget.database,
    );

    if (!mounted) return;

    if (result.isSuccess) {
      final activeDatabase = context.read<SqlCommandsNotifier>().activeDatabase;

      if (activeDatabase == widget.database.name) {
        context.read<SqlCommandsNotifier>().activeDatabase = null;
      }
    } else {
      await handleError(context, result);
    }
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
    final notifier = context.watch<SqlCommandsNotifier>();
    final isActive = notifier.activeDatabase == widget.database.label;

    final borderRadius = BorderRadius.circular(10.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Material(
        color: isActive ? Colors.grey.shade300.withAlpha(30) : Colors.white,
        borderRadius: borderRadius,
        elevation: 0.0,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: _selectDatabase,
          splashColor: Colors.black12,
          highlightColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: isActive
                    ? Colors.black.withAlpha(40)
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
              leading: Icon(
                Icons.storage_rounded,
                color: isActive ? Colors.black : Colors.grey.shade600,
              ),
              title: Text(
                widget.database.label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.black : Colors.grey.shade800,
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
                items: <PopupMenuItem>[
                  PopupMenuItem(
                    onTap: _onToggleFavorite,
                    child: Text(_isFavorite ? 'Unfavorite' : 'Favorite'),
                  ),
                  PopupMenuItem(
                    onTap: _showDeleteDialog,
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
