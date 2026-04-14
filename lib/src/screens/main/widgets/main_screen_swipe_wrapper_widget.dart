import 'package:flutter/material.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

class MainScreenSwipeWrapper extends StatelessWidget {
  const MainScreenSwipeWrapper({
    super.key,
    required this.child,
    required this.navigationNotifier,
    required this.pageController,
  });

  final Widget child;
  final NavigationNotifier navigationNotifier;
  final PageController pageController;

  void handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! < 0) {
      if (navigationNotifier.index < 2) {
        navigationNotifier.setIndex(navigationNotifier.index + 1);
        pageController.jumpToPage(navigationNotifier.index);
      }
    } else if (details.primaryVelocity! > 0) {
      if (navigationNotifier.index > 0) {
        navigationNotifier.setIndex(navigationNotifier.index - 1);
        pageController.jumpToPage(navigationNotifier.index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onHorizontalDragEnd: handleSwipe, child: child);
  }
}
