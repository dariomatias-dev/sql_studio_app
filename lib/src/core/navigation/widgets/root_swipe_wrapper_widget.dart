import 'package:flutter/material.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

/// Wraps [child] to keep the navigation notifier's active index in sync
/// with scroll/swipe notifications from the page view.
class RootSwipeWrapperWidget extends StatelessWidget {
  /// Creates a swipe wrapper syncing [pageController] with [notifier].
  const RootSwipeWrapperWidget({
    required this.child,
    required this.notifier,
    required this.pageController,
    super.key,
  });

  /// Widget subtree that receives scroll notifications.
  final Widget child;

  /// Notifier kept in sync with the current page index.
  final NavigationNotifier notifier;

  /// Controller of the page view being wrapped.
  final PageController pageController;

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
