import 'package:flutter/material.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

class RootSwipeWrapperWidget extends StatelessWidget {
  final Widget child;
  final NavigationNotifier notifier;
  final PageController pageController;

  const RootSwipeWrapperWidget({
    super.key,
    required this.child,
    required this.notifier,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        if (pageController.hasClients) {
          final page = pageController.page?.round() ?? notifier.index;

          if (page != notifier.index) {
            notifier.setIndex(page);
          }
        }
        return false;
      },
      child: child,
    );
  }
}
