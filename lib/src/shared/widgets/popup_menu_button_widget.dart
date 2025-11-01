import 'package:flutter/material.dart';

class PopupMenuButtonWidget extends StatelessWidget {
  final List<PopupMenuEntry> items;

  const PopupMenuButtonWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Options',
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black87),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      itemBuilder: (context) => items,
    );
  }
}
