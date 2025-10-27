import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialog_widget.dart';

class DrawerDatabaseListTileWidget extends StatefulWidget {
  const DrawerDatabaseListTileWidget({super.key, required this.name});

  final String name;

  @override
  State<DrawerDatabaseListTileWidget> createState() =>
      _DrawerDatabaseListTileWidgetState();
}

class _DrawerDatabaseListTileWidgetState
    extends State<DrawerDatabaseListTileWidget> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: 'Attention',
          content: const Text(
            'Are you sure you want to permanently delete this item? This action cannot be undone.',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CancelButtonWidget(),
            ButtonWidget(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Delete',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderColor: Colors.red,
            ),
          ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        leading: const Icon(Icons.storage_outlined, color: Colors.black87),
        title: Text(
          widget.name,
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
              onTap: _showDialog,
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
