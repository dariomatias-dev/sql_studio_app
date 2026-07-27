import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/constants/urls.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/screens/about/licenses_screen.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/settings_section/settings_card_widget.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/settings_section/settings_section_widget.dart';
import 'package:sql_studio/src/features/app_version/presentation/providers.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/error_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screen presenting general information about the application: its icon,
/// name, description, build version, and a licenses page.
class AboutScreen extends ConsumerWidget {
  /// Creates the about screen.
  const AboutScreen({super.key});

  Future<void> _openUrl(BuildContext context, String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (!context.mounted) return;

      final l10n = AppLocalizations.of(context)!;

      await ErrorDialogWidget.show(
        context,
        title: l10n.errorOpeningUrl,
        description: l10n.errorOpeningUrlDescription(url),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final version = ref.watch(appVersionViewModelProvider).formattedVersion;

    return ScaffoldWidget(
      appBar: AppBar(title: Text(l10n.about)),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/icons/sql_studio_icon_transparent.png',
                    width: 88,
                    height: 88,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'SQL Studio',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.versionLabel(version),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: context.colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: Text(
                l10n.appDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: context.colors.black,
                ),
              ),
            ),
            SettingsSectionWidget(
              title: l10n.information,
              children: <Widget>[
                SettingsCardWidget(
                  onTap: () {
                    unawaited(
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const LicensesScreen(),
                        ),
                      ),
                    );
                  },
                  title: l10n.licenses,
                  icon: Icons.description_outlined,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Material(
                color: context.colors.transparent,
                child: InkWell(
                  onTap: () => _openUrl(context, Urls.developerGithub),
                  borderRadius: BorderRadius.circular(AppRadii.full),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 15,
                          color: context.colors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.developedBy('Dario Matias'),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: context.colors.textMuted,
                            decoration: TextDecoration.underline,
                            decorationColor: context.colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
