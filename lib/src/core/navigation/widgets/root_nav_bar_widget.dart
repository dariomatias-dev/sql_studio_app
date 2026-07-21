import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_shadows.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';

/// Bottom navigation bar switching between the app's main pages.
class RootNavBarWidget extends ConsumerWidget {
  /// Creates the bottom navigation bar driven by [pageController].
  const RootNavBarWidget({required this.pageController, super.key});

  /// Controller for the page view this nav bar drives.
  final PageController pageController;

  void _onTab(WidgetRef ref, int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(navigationViewModelProvider.notifier).index = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navigationViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.elevated,
        ),
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              alignment: Alignment(index * 1.0 - 1.0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.24,
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                _NavBarItem(
                  icon: Icons.grid_view_outlined,
                  activeIcon: Icons.grid_view_rounded,
                  label: l10n.home,
                  isSelected: index == 0,
                  onTap: () => _onTab(ref, 0),
                ),
                _NavBarItem(
                  icon: Icons.dns_outlined,
                  activeIcon: Icons.dns_rounded,
                  label: l10n.databases,
                  isSelected: index == 1,
                  onTap: () => _onTab(ref, 1),
                ),
                _NavBarItem(
                  icon: Icons.tune_outlined,
                  activeIcon: Icons.tune_rounded,
                  label: l10n.settings,
                  isSelected: index == 2,
                  onTap: () => _onTab(ref, 2),
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
  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

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
                size: 24,
                color: isSelected ? Colors.black : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? Colors.black : AppColors.textMuted,
                fontSize: 10,
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
