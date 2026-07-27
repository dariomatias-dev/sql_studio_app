import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/theme_selector_sheet/theme_selector_sheet_option_widget.dart';

/// Bottom sheet that lists the theme modes supported by the app for
/// selection.
class ThemeSelectorSheetWidget extends ConsumerWidget {
  /// Creates the theme selector sheet.
  const ThemeSelectorSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
        border: Border(
          top: BorderSide(color: context.colors.border),
          left: BorderSide(color: context.colors.border),
          right: BorderSide(color: context.colors.border),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: context.colors.controlInactive,
              borderRadius: BorderRadius.circular(AppRadii.full),
            ),
          ),
          Text(
            l10n.theme,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            spacing: 4,
            children: <Widget>[
              ThemeSelectorSheetOptionWidget(
                mode: ThemeMode.system,
                label: l10n.themeSystem,
                icon: Icons.brightness_auto_rounded,
              ),
              ThemeSelectorSheetOptionWidget(
                mode: ThemeMode.light,
                label: l10n.themeLight,
                icon: Icons.light_mode_rounded,
              ),
              ThemeSelectorSheetOptionWidget(
                mode: ThemeMode.dark,
                label: l10n.themeDark,
                icon: Icons.dark_mode_rounded,
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
