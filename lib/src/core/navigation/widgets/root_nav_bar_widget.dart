import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

class RootNavBarWidget extends StatelessWidget {
  final NavigationNotifier notifier;
  final PageController pageController;

  const RootNavBarWidget({
    super.key,
    required this.notifier,
    required this.pageController,
  });

  List<GButton> _buttons(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return <GButton>[
      _buildButton(
        icon: Icons.circle_outlined,
        text: appLocalizations.home,
        selected: notifier.index == 0,
      ),
      _buildButton(
        icon: Icons.folder_open_outlined,
        text: appLocalizations.databases,
        selected: notifier.index == 1,
      ),
      _buildButton(
        icon: Icons.settings_outlined,
        text: appLocalizations.settings,
        selected: notifier.index == 2,
      ),
    ];
  }

  GButton _buildButton({
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
      margin: const EdgeInsets.all(10.0),
    );
  }

  void _onTab(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifier.setIndex(index);

    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GNav(
        onTabChange: _onTab,
        backgroundColor: Colors.white,
        gap: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        selectedIndex: notifier.index,
        color: Colors.grey.shade600,
        activeColor: Colors.black,
        tabBackgroundColor: Colors.transparent,
        tabBorder: Border.all(color: Colors.transparent),
        tabBorderRadius: 50.0,
        haptic: false,
        tabs: _buttons(context),
      ),
    );
  }
}
