import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';

import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_shadows.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';

/// The app's base dialog chrome: title, scrollable content and
/// action buttons.
class DialogWidget extends StatelessWidget {
  /// Creates a dialog with the given [content] and optional [title]
  /// and [actions].
  const DialogWidget({
    required this.content,
    super.key,
    this.title,
    this.actions,
  });

  /// Optional title displayed at the top of the dialog.
  final String? title;

  /// Main content displayed in the scrollable body.
  final Widget content;

  /// Optional row of action widgets displayed at the bottom.
  final List<Widget>? actions;

  /// Displays a [DialogWidget] and returns the result once it's
  /// dismissed.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget content,
    String? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return DialogWidget(title: title, content: content, actions: actions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.overlay,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null) ...<Widget>[
              Align(
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: AppColors.black.withAlpha(140),
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  child: content,
                ),
              ),
            ),
            if (actions != null && actions!.isNotEmpty) ...<Widget>[
              const SizedBox(height: 40),
              Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!.builder((action, index) {
                  return Expanded(child: action);
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
