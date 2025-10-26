import 'package:flutter/material.dart';

class DrawerDatabaseListTileWidget extends StatelessWidget {
  const DrawerDatabaseListTileWidget({super.key, required this.name, this.onTap});

  final String name;
  final VoidCallback? onTap;

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
        title: Text(name, style: const TextStyle(color: Colors.black)),
        trailing: PopupMenuButton<int>(
          color: Colors.white,
          icon: const Icon(Icons.more_vert, color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          itemBuilder: (context) => <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(value: 2, child: Text('Delete')),
          ],
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 6.0,
        ),
      ),
    );
  }
}
