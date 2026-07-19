import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchWidget({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.black,
      inactiveThumbColor: const Color(0xFFADADAD),
      inactiveTrackColor: const Color(0xFFF0F0F0),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => value ? Colors.black : const Color(0xFFE0E0E0),
      ),
      trackOutlineWidth: const WidgetStatePropertyAll(1.0),
      thumbIcon: WidgetStatePropertyAll(
        Icon(
          Icons.circle,
          color: value ? Colors.white : Colors.transparent,
          size: 0.0,
        ),
      ),
    );
  }
}
