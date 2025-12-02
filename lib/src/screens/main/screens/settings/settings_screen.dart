import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/main/screens/settings/widgets/app_version_widget.dart';
import 'package:sql_studio/src/screens/main/screens/settings/widgets/language_selector_sheet/language_selector_sheet_widget.dart';
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
          final appLocalizations = AppLocalizations.of(context)!;

          return ErrorDialogWidget(
            title: appLocalizations.errorOpeningUrl,
            description: appLocalizations.errorOpeningUrlDescription(url),
          );
        },
      );
    }
  }

  void _openLanguageSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const LanguageSelectorSheetWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final appLocalizations = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      showExitButton: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            SettingsSectionWidget(
              title: appLocalizations.general,
              children: <Widget>[
                SettingsCardWidget(
                  onTap: _openLanguageSelector,
                  title: appLocalizations.language,
                  icon: Icons.arrow_forward_ios,
                ),
                SettingsCardWidget(
                  onTap: () {
                    context.push(RouteNames.sqlSuggestionSettingsPath);
                  },
                  title: appLocalizations.sqlSuggestions,
                  icon: Icons.arrow_forward_ios,
                ),
                SettingsCardWidget(
                  onTap: () {
                    context.push(RouteNames.workspaceLayoutSettings);
                  },
                  title: appLocalizations.workspaceLayout,
                  icon: Icons.arrow_forward_ios,
                ),
              ],
            ),
            SettingsSectionWidget(
              title: appLocalizations.information,
              children: <Widget>[
                const AppVersionWidget(),
                SettingsCardWidget(
                  onTap: () {
                    _openUrl('https://sql-studio.vercel.app/');
                  },
                  title: appLocalizations.officialWebsite,
                  icon: Icons.open_in_new,
                ),
                SettingsCardWidget(
                  onTap: () {
                    _openUrl('https://sql-studio.vercel.app/privacy-policy');
                  },
                  title: appLocalizations.privacyPolicy,
                  icon: Icons.open_in_new,
                ),
                SettingsCardWidget(
                  onTap: () {
                    _openUrl('https://sql-studio.vercel.app/contact');
                  },
                  title: appLocalizations.contact,
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
