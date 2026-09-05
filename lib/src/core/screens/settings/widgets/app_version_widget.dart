import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/features/app_version/presentation/app_version_providers.dart';

/// Small caption that displays the current app build version.
class AppVersionWidget extends ConsumerWidget {
  /// Creates the app version caption.
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(appVersionViewModelProvider).formattedVersion;

    return Text(
      'Build v$version',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: context.colors.textMuted,
        letterSpacing: 0.2,
      ),
    );
  }
}
