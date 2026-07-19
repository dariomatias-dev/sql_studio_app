import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/routes/app_router.dart';

/// Root widget of the SQL Studio application, wiring up routing and
/// localization for the whole app.
class SqlStudioApp extends ConsumerWidget {
  /// Creates the SQL Studio app.
  const SqlStudioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocalizationViewModelProvider);

    return MaterialApp.router(
      title: 'SQL Studio',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
