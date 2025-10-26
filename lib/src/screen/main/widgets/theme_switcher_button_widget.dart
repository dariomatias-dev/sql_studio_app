import 'package:flutter/material.dart';

class ThemeSwitcherButtonWidget extends StatelessWidget {
  const ThemeSwitcherButtonWidget({
    super.key,
    required this.isDarkTheme,
    required this.onToggle,
  });

  final bool isDarkTheme;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: Colors.black,
      ),
      onPressed: onToggle,
      splashRadius: 24.0,
      tooltip: 'Toggle Theme',
    );
  }
}
