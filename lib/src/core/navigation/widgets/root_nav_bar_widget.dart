import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

class RootNavBarWidget extends StatelessWidget {
  final PageController pageController;

  const RootNavBarWidget({super.key, required this.pageController});

  void _onTab(BuildContext context, NavigationNotifier notifier, int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifier.setIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final NavigationNotifier notifier = context.watch<NavigationNotifier>();
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        height: 72.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 30.0,
              offset: const Offset(0.0, 15.0),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              alignment: Alignment((notifier.index * 1.0 - 1.0), 0.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.24,
                height: 48.0,
                margin: const EdgeInsets.symmetric(horizontal: 14.0),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                _NavBarItem(
                  icon: Icons.grid_view_outlined,
                  activeIcon: Icons.grid_view_rounded,
                  label: l10n.home,
                  isSelected: notifier.index == 0,
                  onTap: () => _onTab(context, notifier, 0),
                ),
                _NavBarItem(
                  icon: Icons.dns_outlined,
                  activeIcon: Icons.dns_rounded,
                  label: l10n.databases,
                  isSelected: notifier.index == 1,
                  onTap: () => _onTab(context, notifier, 1),
                ),
                _NavBarItem(
                  icon: Icons.tune_outlined,
                  activeIcon: Icons.tune_rounded,
                  label: l10n.settings,
                  isSelected: notifier.index == 2,
                  onTap: () => _onTab(context, notifier, 2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isSelected ? activeIcon : icon,
                key: ValueKey<IconData>(isSelected ? activeIcon : icon),
                size: 24.0,
                color: isSelected ? Colors.white : const Color(0xFF757575),
              ),
            ),
            const SizedBox(height: 4.0),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF757575),
                fontSize: 10.0,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                letterSpacing: 0.8,
              ),
              child: Text(label.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
