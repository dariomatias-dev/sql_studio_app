import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/screens/main/screens/databases/databases_screen.dart';
import 'package:sql_studio/src/screens/main/screens/home/home_screen.dart';
import 'package:sql_studio/src/screens/main/widgets/app_bar_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_widget.dart';
import 'package:sql_studio/src/screens/main/screens/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

  final _screens = <Widget>[HomeScreen(), DatabasesScreen(), SettingsScreen()];

  GButton _buildGButton({
    required IconData icon,
    required String text,
    required bool isSelected,
  }) {
    return GButton(
      icon: icon,
      text: text,
      iconColor: isSelected ? Colors.black : Colors.grey.shade600,
      textColor: isSelected ? Colors.black : Colors.grey.shade600,
      border: isSelected ? Border.all(color: Colors.black) : null,
      backgroundColor: Colors.transparent,
      rippleColor: Colors.transparent,
      hoverColor: Colors.transparent,
      margin: const EdgeInsets.all(10.0),
    );
  }

  void _onPageChanged(BuildContext context, int index) {
    context.read<MainScreenNotifier>().changeScreen(index);
  }

  void _onTabChange(BuildContext context, int index) {
    context.read<MainScreenNotifier>().changeScreen(index);
    _pageController.jumpToPage(index);
  }

  void _onHorizontalSwipe(BuildContext context, DragEndDetails details) {
    final notifier = context.read<MainScreenNotifier>();
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! < 0) {
      if (notifier.currentIndex < _screens.length - 1) {
        _onTabChange(context, notifier.currentIndex + 1);
      }
    } else if (details.primaryVelocity! > 0) {
      if (notifier.currentIndex > 0) {
        _onTabChange(context, notifier.currentIndex - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MainScreenNotifier>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients &&
          _pageController.page?.round() != notifier.currentIndex) {
        _pageController.jumpToPage(notifier.currentIndex);
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: GestureDetector(
        onHorizontalDragEnd: (details) => _onHorizontalSwipe(context, details),
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) => _onPageChanged(context, index),
          children: _screens,
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onHorizontalDragEnd: (details) => _onHorizontalSwipe(context, details),
        child: SafeArea(
          child: GNav(
            backgroundColor: Colors.white,
            gap: 8.0,
            selectedIndex: notifier.currentIndex,
            onTabChange: (index) => _onTabChange(context, index),
            color: Colors.grey.shade600,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.transparent,
            tabBorderRadius: 50.0,
            tabBorder: Border.all(color: Colors.transparent),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            haptic: false,
            tabs: <GButton>[
              _buildGButton(
                icon: Icons.circle_outlined,
                text: 'Home',
                isSelected: notifier.currentIndex == 0,
              ),
              _buildGButton(
                icon: Icons.folder_open_outlined,
                text: 'Databases',
                isSelected: notifier.currentIndex == 1,
              ),
              _buildGButton(
                icon: Icons.settings_outlined,
                text: 'Settings',
                isSelected: notifier.currentIndex == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
