import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_localization_notifier.dart';
import 'package:sql_studio/src/core/routes/app_router.dart';

class SqlStudioApp extends StatelessWidget {
  const SqlStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLocalizationNotifier>(
      builder: (context, value, child) {
        return MaterialApp.router(
          title: 'SQL Studio',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          locale: value.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        );
      },
    );
  }
}
