import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';

class MainScreenNavButtonsWidget extends StatelessWidget {
  const MainScreenNavButtonsWidget({
    super.key,
    required this.notifier,
    required this.pageController,
  });

  final MainScreenNotifier notifier;
  final PageController pageController;

  List<GButton> buttons(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return <GButton>[
      buildButton(
        icon: Icons.circle_outlined,
        text: appLocalizations.home,
        selected: notifier.currentIndex == 0,
      ),
      buildButton(
        icon: Icons.folder_open_outlined,
        text: appLocalizations.databases,
        selected: notifier.currentIndex == 1,
      ),
      buildButton(
        icon: Icons.settings_outlined,
        text: appLocalizations.settings,
        selected: notifier.currentIndex == 2,
      ),
    ];
  }

  GButton buildButton({
    required IconData icon,
    required String text,
    required bool selected,
  }) {
    return GButton(
      icon: icon,
      text: text,
      iconColor: selected ? Colors.black : Colors.grey.shade600,
      textColor: selected ? Colors.black : Colors.grey.shade600,
      border: selected ? Border.all(color: Colors.black) : null,
      backgroundColor: Colors.transparent,
      rippleColor: Colors.transparent,
      hoverColor: Colors.transparent,
      margin: const EdgeInsets.all(10),
    );
  }

  void onTab(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifier.changeScreen(index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GNav(
        onTabChange: onTab,
        backgroundColor: Colors.white,
        gap: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        selectedIndex: notifier.currentIndex,
        color: Colors.grey.shade600,
        activeColor: Colors.black,
        tabBackgroundColor: Colors.transparent,
        tabBorder: Border.all(color: Colors.transparent),
        tabBorderRadius: 50.0,
        haptic: false,
        tabs: buttons(context),
      ),
    );
  }
}
