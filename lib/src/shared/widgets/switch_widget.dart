import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeThumbColor: Colors.green,
      activeTrackColor: Colors.green.withAlpha(80),
      trackColor: WidgetStatePropertyAll(Colors.white),
      trackOutlineColor: WidgetStatePropertyAll(Colors.black),
      trackOutlineWidth: WidgetStatePropertyAll(0.5),
      inactiveThumbColor: Colors.grey.shade400,
      inactiveTrackColor: Colors.grey.withAlpha(60),
      onChanged: onChanged,
    );
  }
}
