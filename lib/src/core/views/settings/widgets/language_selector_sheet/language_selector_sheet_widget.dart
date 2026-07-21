import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/views/settings/widgets/language_selector_sheet/language_selector_sheet_option_widget.dart';

/// Bottom sheet that lists the languages supported by the app for selection.
class LanguageSelectorSheetWidget extends ConsumerWidget {
  /// Creates the language selector sheet.
  const LanguageSelectorSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watched so the sheet rebuilds and refreshes the selected option when
    // the active locale changes.
    ref.watch(appLocalizationViewModelProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: AppColors.controlInactive,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            spacing: 4,
            children: ['English', 'Español', 'Português'].builder((
              lang,
              index,
            ) {
              return LanguageSelectorSheetOptionWidget(
                lang: lang,
                code: AppLocalizations.supportedLocales[index].languageCode,
              );
            }),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
