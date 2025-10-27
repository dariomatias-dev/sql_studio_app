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
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        leading: const Icon(Icons.storage_outlined, color: Colors.black),
        title: Text(widget.name, style: const TextStyle(color: Colors.black)),
        trailing: PopupMenuButton(
          tooltip: 'Show Menu',
          color: Colors.white,
          icon: const Icon(Icons.more_vert, color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(onTap: _showDialog, child: Text('Delete'),),
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
