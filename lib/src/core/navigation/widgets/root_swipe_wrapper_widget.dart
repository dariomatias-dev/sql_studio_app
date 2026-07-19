import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/navigation_provider.dart';

/// Wraps [child] to keep the navigation index in sync with scroll/swipe
/// notifications from the page view.
class RootSwipeWrapperWidget extends ConsumerWidget {
  /// Creates a swipe wrapper syncing [pageController] with the current
  /// navigation index.
  const RootSwipeWrapperWidget({
    required this.child,
    required this.pageController,
    super.key,
  });

  /// Widget subtree that receives scroll notifications.
  final Widget child;

  /// Controller of the page view being wrapped.
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        if (pageController.hasClients) {
          final notifier = ref.read(navigationViewModelProvider.notifier);
          final currentIndex = ref.read(navigationViewModelProvider);
          final page = pageController.page?.round() ?? currentIndex;

          if (page != currentIndex) {
            notifier.index = page;
          }
        }
        return false;
      },
      child: child,
    );
  }
}
