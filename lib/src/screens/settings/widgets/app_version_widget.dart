import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/notifiers/app_version_notifier.dart';

import 'package:sql_studio/src/screens/settings/widgets/settings_section/settings_card_widget.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final version = context.watch<AppVersionNotifier>().version;

    return SettingsCardWidget(
      onTap: () {},
      title: AppLocalizations.of(context)!.appVersion,
      subtitle: version,
    );
  }
}
