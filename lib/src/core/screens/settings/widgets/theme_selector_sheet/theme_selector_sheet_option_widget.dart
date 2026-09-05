import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_durations.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

/// A single selectable theme mode option shown in the theme selector sheet.
class ThemeSelectorSheetOptionWidget extends ConsumerWidget {
  /// Creates a theme option for [mode], shown as [label] with [icon].
  const ThemeSelectorSheetOptionWidget({
    required this.mode,
    required this.label,
    required this.icon,
    super.key,
  });

  /// Theme mode this option applies when selected.
  final ThemeMode mode;

  /// Display name of the theme mode shown to the user.
  final String label;

  /// Icon shown alongside [label].
  final IconData icon;

  Future<void> _changeThemeMode(BuildContext context, WidgetRef ref) async {
    await ref
        .read(appThemeModeViewModelProvider.notifier)
        .changeThemeMode(mode);

    if (!context.mounted) return;

    Navigator.pop(context);

    unawaited(
      AppToast.of(
        context,
      ).show(AppLocalizations.of(context)!.themeUpdated(label)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = mode == ref.watch(appThemeModeViewModelProvider);
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: colors.transparent,
        child: InkWell(
          onTap: () => _changeThemeMode(context, ref),
          borderRadius: BorderRadius.circular(AppRadii.md),
          child: AnimatedContainer(
            duration: AppDurations.md,
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.md),
              color: isSelected ? colors.black : colors.background,
              border: Border.all(
                color: isSelected ? colors.black : colors.border,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 20,
                  color: isSelected ? colors.white : colors.black,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: isSelected ? colors.white : colors.black,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: colors.white,
                    size: 20,
                  )
                else
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.controlInactive,
                        width: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
