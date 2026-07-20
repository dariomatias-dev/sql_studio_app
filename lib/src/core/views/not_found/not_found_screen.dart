import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

/// Screen shown when a navigation route could not be resolved.
class NotFoundScreen extends StatelessWidget {
  /// Creates the not found screen.
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              Text(
                appLocalizations.screenNotFound,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                appLocalizations.screenNotFoundDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                onPressed: () => context.go('/'),
                style: ButtonStyleType.red,
                text: appLocalizations.goHome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
