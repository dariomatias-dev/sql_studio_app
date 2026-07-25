import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';

/// A three-dot overflow menu button with the app's rounded styling.
class PopupMenuButtonWidget extends StatelessWidget {
  /// Creates a popup menu button showing the given [items].
  const PopupMenuButtonWidget({required this.items, this.onOpened, super.key});

  /// Menu entries displayed when the button is tapped.
  final List<PopupMenuEntry<void>> items;

  /// Called right when the menu opens.
  final VoidCallback? onOpened;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      tooltip: AppLocalizations.of(context)!.options,
      color: AppColors.white,
      icon: const Icon(Icons.more_vert, color: AppColors.black87),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xs),
      ),
      onOpened: onOpened,
      itemBuilder: (context) => items,
    );
  }
}
