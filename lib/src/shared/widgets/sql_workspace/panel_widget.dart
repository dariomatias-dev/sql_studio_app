import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    super.key,
    required this.title,
    required this.isFullScreen,
    required this.onFullScreen,
    required this.actions,
    required this.child,
    this.databaseName,
  });

  final String title;
  final String? databaseName;
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
                onPressed: onFullScreen,
                tooltip: isFullScreen ? 'Exit Fullscreen' : 'Enter Fullscreen',
                icon: Icon(
                  isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (databaseName != null)
                      Text(
                        'Database: $databaseName',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              ...actions,
            ],
          ),
          Expanded(
            child: ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border.symmetric(
                    vertical: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
