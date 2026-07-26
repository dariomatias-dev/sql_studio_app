import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_shadows.dart';

/// A compact pill switch matching the app's own design system instead of
/// Material's stock [Switch] shape.
class SwitchWidget extends StatelessWidget {
  /// Creates a styled switch reflecting [value].
  const SwitchWidget({required this.value, required this.onChanged, super.key});

  /// Current on/off state of the switch.
  final bool value;

  /// Called with the new value when the switch is toggled.
  final ValueChanged<bool> onChanged;

  static const double _width = 44;
  static const double _height = 26;
  static const double _thumbSize = 20;
  static const Duration _duration = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeOut,
        width: _width,
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: value ? AppColors.black : AppColors.background,
          borderRadius: BorderRadius.circular(AppRadii.full),
          border: Border.all(
            color: value ? AppColors.black : AppColors.border,
          ),
        ),
        child: AnimatedAlign(
          duration: _duration,
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: _duration,
            curve: Curves.easeOut,
            width: _thumbSize,
            height: _thumbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? AppColors.white : AppColors.controlInactive,
              boxShadow: AppShadows.chip,
            ),
          ),
        ),
      ),
    );
  }
}
