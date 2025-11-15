import 'package:flutter/material.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';

class MainScreenSwipeWrapper extends StatelessWidget {
  const MainScreenSwipeWrapper({
    super.key,
    required this.child,
    required this.notifier,
    required this.pageController,
  });

  final Widget child;
  final MainScreenNotifier notifier;
  final PageController pageController;

  void handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! < 0) {
      if (notifier.currentIndex < 2) {
        notifier.changeScreen(notifier.currentIndex + 1);
        pageController.jumpToPage(notifier.currentIndex);
      }
    } else if (details.primaryVelocity! > 0) {
      if (notifier.currentIndex > 0) {
        notifier.changeScreen(notifier.currentIndex - 1);
        pageController.jumpToPage(notifier.currentIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onHorizontalDragEnd: handleSwipe, child: child);
  }
}
