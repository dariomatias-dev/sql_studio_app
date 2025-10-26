import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:sql_studio/src/screen/databases/databases_screen.dart';
import 'package:sql_studio/src/screen/home/home_screen.dart';
import 'package:sql_studio/src/screen/main/widgets/app_bar_widget.dart';
import 'package:sql_studio/src/screen/main/widgets/create_database_dialog_widget.dart';
import 'package:sql_studio/src/screen/main/widgets/drawer_widget.dart';
import 'package:sql_studio/src/screen/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

  int _selectedIndex = 0;

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

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  void _onTabChange(int index) {
    _pageController.jumpToPage(index);

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

  void _showCreateDatabaseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDatabaseDialogWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: GestureDetector(
        onHorizontalDragEnd: _onHorizontalSwipe,
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDatabaseDialog,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.grey.shade300,
        child: Icon(Icons.add, color: Colors.black),
      ),
      bottomNavigationBar: GestureDetector(
        onHorizontalDragEnd: _onHorizontalSwipe,
        child: SafeArea(
          child: GNav(
            backgroundColor: Colors.white,
            gap: 8.0,
            selectedIndex: _selectedIndex,
            onTabChange: _onTabChange,
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
    );
  }
}
