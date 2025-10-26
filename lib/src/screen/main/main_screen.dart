import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:sql_studio/src/screen/databases/databases_screen.dart';
import 'package:sql_studio/src/screen/home/home_screen.dart';
import 'package:sql_studio/src/screen/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen(),
    DatabasesScreen(),
    SettingsScreen(),
  ];

  GButton _buildGButton({
    required IconData icon,
    required String text,
    required bool isSelected,
  }) {
    return GButton(
      icon: icon,
      text: text,
      iconColor: isSelected ? Colors.black : Colors.grey[600],
      textColor: isSelected ? Colors.black : Colors.grey[600],
      border: isSelected ? Border.all(color: Colors.black) : null,
      backgroundColor: Colors.transparent,
      rippleColor: Colors.transparent,
      hoverColor: Colors.transparent,
      margin: const EdgeInsets.all(10),
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  void _onTabChange(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _selectedIndex = index);
  }

  void _onHorizontalSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! < 0) {
      if (_selectedIndex < _screens.length - 1) {
        _onTabChange(_selectedIndex + 1);
      }
    } else if (details.primaryVelocity! > 0) {
      if (_selectedIndex > 0) {
        _onTabChange(_selectedIndex - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: _onHorizontalSwipe,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onHorizontalDragEnd: _onHorizontalSwipe,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GNav(
              backgroundColor: Colors.white,
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: _onTabChange,
              color: Colors.grey.shade600,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.transparent,
              tabBorderRadius: 50,
              tabBorder: Border.all(color: Colors.transparent),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              haptic: false,
              tabs: [
                _buildGButton(
                  icon: Icons.circle_outlined,
                  text: 'Home',
                  isSelected: _selectedIndex == 0,
                ),
                _buildGButton(
                  icon: Icons.folder_open_outlined,
                  text: 'Databases',
                  isSelected: _selectedIndex == 1,
                ),
                _buildGButton(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                  isSelected: _selectedIndex == 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
