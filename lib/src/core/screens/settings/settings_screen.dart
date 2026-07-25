import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/constants/urls.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/app_version_widget.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/language_selector_sheet/language_selector_sheet_widget.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/settings_section/settings_card_widget.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/settings_section/settings_section_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/error_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screen that exposes general, language and information settings.
class SettingsScreen extends ConsumerStatefulWidget {
  /// Creates the settings screen.
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _currentLanguageName() {
    final code = ref.watch(appLocalizationViewModelProvider).languageCode;
    final index = AppLocalizations.supportedLocales.indexWhere(
      (locale) => locale.languageCode == code,
    );

    return index == -1 ? '' : languageNames[index];
  }

  Future<void> _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (!mounted) return;

      final l10n = AppLocalizations.of(context)!;

      await ErrorDialogWidget.show(
        context,
        title: l10n.errorOpeningUrl,
        description: l10n.errorOpeningUrlDescription(url),
      );
    }
  }

  void _openLanguageSelector() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.transparent,
        builder: (context) => const LanguageSelectorSheetWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final l10n = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      showExitButton: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.settings,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
              ),
            ),
            SettingsSectionWidget(
              title: l10n.general,
              children: <Widget>[
                SettingsCardWidget(
                  onTap: _openLanguageSelector,
                  title: l10n.language,
                  icon: Icons.language_rounded,
                  value: _currentLanguageName(),
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
            const SizedBox(height: 28),
            const Center(child: AppVersionWidget()),
          ],
        ),
      ),
    );
  }
}
