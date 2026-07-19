import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/app_version_notifier.dart';

/// Small badge that displays the current app build version.
class AppVersionWidget extends StatelessWidget {
  /// Creates the app version badge.
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final version = context.watch<AppVersionNotifier>().version;

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Text(
        'BUILD v$version',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Color(0xFF8E8E8E),
          letterSpacing: 0.5,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
