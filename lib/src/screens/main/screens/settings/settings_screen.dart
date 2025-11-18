import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/main/screens/settings/widgets/app_version_widget.dart';
import 'package:sql_studio/src/screens/main/screens/settings/widgets/settings_section/settings_card_widget.dart';
import 'package:sql_studio/src/screens/main/screens/settings/widgets/settings_section/settings_section_widget.dart';

import 'package:sql_studio/src/shared/widgets/dialogs/error_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  BuildContext _getContext() => context;

  Future<void> _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      await showDialog(
        context: _getContext(),
        builder: (context) {
          return ErrorDialogWidget(
            title: 'Error opening URL',
            description: 'The URL $url could not be opened.',
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScaffoldWidget(
      showExitButton: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            SettingsSectionWidget(
              title: 'General',
              children: <Widget>[
                // SettingsCardWidget(
                //   onTap: () {},
                //   title: 'Language',
                //   icon: Icons.arrow_forward_ios,
                // ),
                SettingsCardWidget(
                  onTap: () {
                    context.push(RouteNames.sqlSuggestionSettingsPath);
                  },
                  title: 'SQL Suggestions',
                  icon: Icons.arrow_forward_ios,
                ),
                SettingsCardWidget(
                  onTap: () {
                    context.push(RouteNames.workspaceLayout);
                  },
                  title: 'Workspace Layout',
                  icon: Icons.arrow_forward_ios,
                ),
              ],
            ),
            SettingsSectionWidget(
              title: 'Information',
              children: <Widget>[
                AppVersionWidget(),
                SettingsCardWidget(
                  onTap: () => _openUrl('https://sql-studio.vercel.app/'),
                  title: 'Official Website',
                  icon: Icons.open_in_new,
                ),
                SettingsCardWidget(
                  onTap: () =>
                      _openUrl('https://sql-studio.vercel.app/privacy-policy'),
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
          ],
        ),
      ),
    );
  }
}
