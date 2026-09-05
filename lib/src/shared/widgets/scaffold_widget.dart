import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// The app's base [Scaffold] wrapper with a consistent app bar and
/// back button.
class ScaffoldWidget extends StatelessWidget {
  /// Creates a scaffold with the given [body].
  const ScaffoldWidget({
    required this.body,
    super.key,
    this.appBar,
    this.showExitButton = true,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  /// App bar configuration. When `null`, no app bar is shown.
  final AppBar? appBar;

  /// Whether to show the leading back/exit button on the app bar.
  final bool showExitButton;

  /// Optional side drawer.
  final Widget? drawer;

  /// Main content of the scaffold.
  final Widget body;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Scaffold body background. Defaults to white.
  final Color? backgroundColor;

  /// Whether the body resizes to avoid the keyboard. Defaults to `true`;
  /// set `false` when the body already manages its own scroll-into-view
  /// (e.g. a code editor), so its layout doesn't reflow with the keyboard.
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? context.colors.white,
      appBar: appBar != null
          ? AppBar(
              backgroundColor: context.colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              shape: Border(
                bottom: BorderSide(color: context.colors.border),
              ),
              leading: showExitButton
                  ? IconButton(
                      onPressed: context.pop,
                      tooltip: AppLocalizations.of(context).exitScreen,
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: context.colors.black54,
                        size: 20,
                      ),
                    )
                  : null,
              title: appBar?.title != null
                  ? Text(
                      (appBar!.title! as Text).data!,
                      style: TextStyle(
                        color: context.colors.black87,
                        fontSize: 20,
                      ),
                    )
                  : null,
              actions: appBar?.actions,
            )
          : null,
      drawer: drawer,
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
