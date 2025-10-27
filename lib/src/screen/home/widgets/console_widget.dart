import 'package:flutter/material.dart';

import 'package:sql_studio/src/screen/home/widgets/panel_widget.dart';

class ConsoleWidget extends StatelessWidget {
  const ConsoleWidget({
    super.key,
    required this.isFullScreen,
    required this.onFullScreen,
  });

  final bool isFullScreen;
  final VoidCallback onFullScreen;

  @override
  Widget build(BuildContext context) {
    return PanelWidget(
      title: 'Console',
      isFullScreen: isFullScreen,
      onFullScreen: onFullScreen,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          tooltip: 'Clear Console',
          onPressed: () {},
        ),
      ],
      child: const Center(child: Text('Console')),
    );
  }
}
