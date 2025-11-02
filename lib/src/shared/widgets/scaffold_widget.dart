import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    this.appBar,
    this.showExitButton = true,
    this.drawer,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final AppBar? appBar;
  final bool showExitButton;
  final Widget? drawer;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar != null
          ? AppBar(
              backgroundColor: Colors.white,
              leading: showExitButton
                  ? IconButton(
                      onPressed: context.pop,
                      tooltip: 'Exit Screen',
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black54,
                        size: 20.0,
                      ),
                    )
                  : null,
              title: appBar?.title != null
                  ? Text(
                      (appBar!.title! as Text).data!,
                      style: TextStyle(color: Colors.black87, fontSize: 20.0),
                    )
                  : null,
              actions: appBar?.actions,
            )
          : null,
      drawer: drawer,
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
