import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

class DrawerDatabaseListTileWidget extends StatefulWidget {
  const DrawerDatabaseListTileWidget({
    super.key,
    required this.database,
    required this.toggleFavorite,
    required this.onDelete,
  });

  final DatabaseModel database;
  final Future<void> Function() toggleFavorite;
  final Future<void> Function() onDelete;

  @override
  State<DrawerDatabaseListTileWidget> createState() =>
      _DrawerDatabaseListTileWidgetState();
}

class _DrawerDatabaseListTileWidgetState
    extends State<DrawerDatabaseListTileWidget> {
  late bool _isFavorite = widget.database.isFavorite;

  void _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    await widget.toggleFavorite();
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialogWidget(
          title: 'Attention',
          description:
              'Are you sure you want to permanently delete this database? This action cannot be undone.',
          confirmButton: ButtonWidget(
            onPressed: () async {
              context.pop(context);

              await widget.onDelete();
            },
            text: 'Delete',
            style: ButtonStyleType.red,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        leading: const Icon(Icons.storage_outlined, color: Colors.black87),
        title: Text(
          widget.database.label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: PopupMenuButton(
          tooltip: 'Options',
          color: Colors.white,
          icon: const Icon(Icons.more_vert, color: Colors.black87),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: _toggleFavorite,
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
          vertical: 6.0,
        ),
      ),
    );
  }
}
