import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/app_version/presentation/providers.dart';

/// Small badge that displays the current app build version.
class AppVersionWidget extends ConsumerWidget {
  /// Creates the app version badge.
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(appVersionViewModelProvider).formattedVersion;

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
