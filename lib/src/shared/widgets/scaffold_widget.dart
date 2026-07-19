import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar != null
          ? AppBar(
              backgroundColor: Colors.white,
              leading: showExitButton
                  ? IconButton(
                      onPressed: context.pop,
                      tooltip: AppLocalizations.of(context)!.exitScreen,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black54,
                        size: 20,
                      ),
                    )
                  : null,
              title: appBar?.title != null
                  ? Text(
                      (appBar!.title! as Text).data!,
                      style: const TextStyle(
                        color: Colors.black87,
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
