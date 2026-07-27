import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// A three-dot overflow menu button with the app's rounded styling.
class PopupMenuButtonWidget extends StatelessWidget {
  /// Creates a popup menu button showing the given [items].
  const PopupMenuButtonWidget({
    required this.items,
    this.onOpened,
    this.iconColor,
    super.key,
  });

  /// Menu entries displayed when the button is tapped.
  final List<PopupMenuEntry<void>> items;

  /// Called right when the menu opens.
  final VoidCallback? onOpened;

  /// Color of the three-dot trigger icon. Defaults to
  /// [BuildContextExtension.colors]'s `black87`.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      tooltip: AppLocalizations.of(context)!.options,
      color: context.colors.white,
      icon: Icon(
        Icons.more_vert,
        color: iconColor ?? context.colors.black87,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xs),
        side: BorderSide(color: context.colors.border),
      ),
      onOpened: onOpened,
      itemBuilder: (context) => items,
    );
  }
}
