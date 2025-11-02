import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:sql_studio/src/screens/main/screens/settings/widgets/settings_section/settings_card_widget.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        String versionText = 'Loading...';
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            versionText = snapshot.data!;
          } else {
            versionText = 'Unknown';
          }
        }

        return SettingsCardWidget(
          onTap: () {},
          title: 'App Version',
          subtitle: versionText,
        );
      },
    );
  }
}
