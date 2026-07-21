import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';

/// A [Switch] styled with the app's black-and-white theme.
class SwitchWidget extends StatelessWidget {
  /// Creates a styled switch reflecting [value].
  const SwitchWidget({required this.value, required this.onChanged, super.key});

  /// Current on/off state of the switch.
  final bool value;

  /// Called with the new value when the switch is toggled.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.black,
      inactiveThumbColor: AppColors.controlInactive,
      inactiveTrackColor: AppColors.background,
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => value ? Colors.black : AppColors.border,
      ),
      trackOutlineWidth: const WidgetStatePropertyAll(1),
      thumbIcon: WidgetStatePropertyAll(
        Icon(
          Icons.circle,
          color: value ? Colors.white : Colors.transparent,
          size: 0,
        ),
      ),
    );
  }
}
