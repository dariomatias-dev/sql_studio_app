import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/settings/widgets/settings_card_widget.dart';
import 'package:sql_studio/src/screens/settings/widgets/settings_section_title_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            const SettingsSectionTitleWidget(title: 'General'),
            SettingsCardWidget(
              onTap: () {},
              title: 'Language',
              icon: Icons.arrow_forward_ios,
            ),
            SettingsCardWidget(
              onTap: () {
                context.push(RouteNames.sqlCommandSettings);
              },
              title: 'SQL Commands',
              icon: Icons.arrow_forward_ios,
            ),
            const SettingsSectionTitleWidget(title: 'Information'),
            SettingsCardWidget(
              onTap: () {},
              title: 'App Version',
              subtitle: '1.0.0',
            ),
            SettingsCardWidget(
              onTap: () {},
              title: 'Official Website',
              icon: Icons.open_in_new,
            ),
            SettingsCardWidget(
              onTap: () {},
              title: 'Privacy Policy',
              icon: Icons.open_in_new,
            ),
            SettingsCardWidget(
              onTap: () {},
              title: 'Contact',
              icon: Icons.open_in_new,
            ),
          ],
        ),
      ),
    );
  }
}
