import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// A common panel frame used by the SQL workspace widgets, providing a
/// header with title, database name, action buttons, and a body area.
class PanelWidget extends StatelessWidget {
  /// Creates a panel wrapping [child] with an optional header.
  const PanelWidget({
    required this.child,
    super.key,
    this.title,
    this.databaseName,
    this.isFullScreen,
    this.onFullScreen,
    this.actions = const <Widget>[],
  });

  /// Title shown in the panel header, if any.
  final String? title;

  /// Name of the active database shown beneath the title, if any.
  final String? databaseName;

  /// Whether the panel is currently expanded to full screen.
  final bool? isFullScreen;

  /// Called when the full screen toggle button is pressed. When null, the
  /// toggle button is not shown.
  final VoidCallback? onFullScreen;

  /// Extra action widgets shown at the end of the header row.
  final List<Widget> actions;

  /// Content displayed in the panel body.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final hasFullScreenButton = onFullScreen != null;

    return ColoredBox(
      color: AppColors.background,
      child: Column(
        children: <Widget>[
          ColoredBox(
            color: AppColors.background,
            child: Row(
              children: <Widget>[
                if (hasFullScreenButton)
                  IconButton(
                    onPressed: onFullScreen,
                    tooltip: isFullScreen ?? false
                        ? appLocalizations.exitFullscreen
                        : appLocalizations.enterFullscreen,
                    icon: Icon(
                      isFullScreen ?? false
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: hasFullScreenButton ? 0 : 14.0,
                    ).copyWith(left: hasFullScreenButton ? 0 : 26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (title != null)
                          Text(
                            title!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (databaseName != null)
                          Text(
                            databaseName!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
                ...actions,
              ],
            ),
          ),
          Expanded(
            child: ClipRect(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border.symmetric(
                    vertical: BorderSide(color: AppColors.border),
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
