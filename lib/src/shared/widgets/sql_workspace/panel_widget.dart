import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    super.key,
    this.title,
    this.databaseName,
    this.isFullScreen,
    this.onFullScreen,
    this.actions = const <Widget>[],
    required this.child,
  });

  final String? title;
  final String? databaseName;
  final bool? isFullScreen;
  final VoidCallback? onFullScreen;
  final List<Widget> actions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasFullScreenButton = onFullScreen != null;

    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              if (hasFullScreenButton)
                IconButton(
                  onPressed: onFullScreen,
                  tooltip: isFullScreen ?? false
                      ? 'Exit Fullscreen'
                      : 'Enter Fullscreen',
                  icon: Icon(
                    isFullScreen ?? false
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: hasFullScreenButton ? 0 : 26.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (title != null)
                        Text(
                          title!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (databaseName != null)
                        Text(
                          databaseName!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
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
