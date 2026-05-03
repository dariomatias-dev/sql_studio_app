import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/constants/urls.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';

import 'package:sql_studio/src/screens/settings/widgets/app_version_widget.dart';
import 'package:sql_studio/src/screens/settings/widgets/language_selector_sheet/language_selector_sheet_widget.dart';
import 'package:sql_studio/src/screens/settings/widgets/settings_section/settings_card_widget.dart';
import 'package:sql_studio/src/screens/settings/widgets/settings_section/settings_section_widget.dart';

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

  Future<void> _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (!mounted) return;

      final AppLocalizations l10n = AppLocalizations.of(context)!;

      await ErrorDialogWidget.show(
        context,
        title: l10n.errorOpeningUrl,
        description: l10n.errorOpeningUrlDescription(url),
      );
    }
  }

  void _openLanguageSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const LanguageSelectorSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      showExitButton: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 140.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 68.0,
                  width: 68.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withAlpha(40),
                        blurRadius: 20.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        l10n.settings,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.0,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const AppVersionWidget(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            SettingsSectionWidget(
              title: l10n.general,
              children: <Widget>[
                SettingsCardWidget(
                  onTap: _openLanguageSelector,
                  title: l10n.language,
                  icon: Icons.language_rounded,
                ),
                SettingsCardWidget(
                  onTap: () => AppRoutes.goToSqlSuggestionSettings(context),
                  title: l10n.sqlSuggestions,
                  icon: Icons.auto_fix_high_rounded,
                ),
                SettingsCardWidget(
                  onTap: () => AppRoutes.goToWorkspaceLayoutSettings(context),
                  title: l10n.workspaceLayout,
                  icon: Icons.dashboard_rounded,
                ),
              ],
            ),
            SettingsSectionWidget(
              title: l10n.information,
              children: <Widget>[
                SettingsCardWidget(
                  onTap: () => _openUrl(Urls.officialWebsite),
                  title: l10n.officialWebsite,
                  icon: Icons.public_rounded,
                ),
                SettingsCardWidget(
                  onTap: () => _openUrl(Urls.officialWebsitePrivacyPolicy),
                  title: l10n.privacyPolicy,
                  icon: Icons.verified_user_rounded,
                ),
                SettingsCardWidget(
                  onTap: () => _openUrl(Urls.officialWebsiteContact),
                  title: l10n.contact,
                  icon: Icons.alternate_email_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
