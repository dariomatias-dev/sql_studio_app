import 'package:flutter/material.dart';

import 'package:sql_studio/src/screens/main/screens/home/home_screen.dart';
import 'package:sql_studio/src/screens/main/screens/databases/databases_screen.dart';
import 'package:sql_studio/src/screens/main/screens/settings/settings_screen.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';

class MainScreenScreensWidget extends StatelessWidget {
  const MainScreenScreensWidget({
    super.key,
    required this.notifier,
    required this.pageController,
  });

  final MainScreenNotifier notifier;
  final PageController pageController;

  List<Widget> get pages => const [
    HomeScreen(),
    DatabasesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients &&
          pageController.page?.round() != notifier.currentIndex) {
        pageController.jumpToPage(notifier.currentIndex);
      }
    });

    return PageView(
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      onPageChanged: notifier.changeScreen,
      children: pages,
    );
  }
}
