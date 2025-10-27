import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    super.key,
    required this.title,
    required this.isFullScreen,
    required this.onFullScreen,
    required this.actions,
    required this.child,
  });

  final String title;
  final VoidCallback onFullScreen;
  final bool isFullScreen;
  final List<Widget> actions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                ),
                onPressed: onFullScreen,
                tooltip: isFullScreen ? 'Exit Fullscreen' : 'Enter Fullscreen',
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ...actions,
            ],
          ),
          Expanded(child: ClipRect(child: child)),
        ],
      ),
    );
  }
}
