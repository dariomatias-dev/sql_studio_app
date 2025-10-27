import 'package:flutter/material.dart';

class ThemeSwitcherButtonWidget extends StatefulWidget {
  const ThemeSwitcherButtonWidget({super.key});

  @override
  State<ThemeSwitcherButtonWidget> createState() =>
      _ThemeSwitcherButtonWidgetState();
}

class _ThemeSwitcherButtonWidgetState extends State<ThemeSwitcherButtonWidget> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        color: Colors.black,
      ),
      onPressed: _toggleTheme,
      splashRadius: 24.0,
      tooltip: 'Toggle Theme',
    );
  }
}
