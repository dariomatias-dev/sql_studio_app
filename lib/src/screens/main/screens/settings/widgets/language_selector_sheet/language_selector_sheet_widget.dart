import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';
import 'package:sql_studio/src/core/locale_controller.dart';

import 'package:sql_studio/src/screens/main/screens/settings/widgets/language_selector_sheet/language_selector_sheet_option_widget.dart';

class LanguageSelectorSheetWidget extends StatefulWidget {
  const LanguageSelectorSheetWidget({super.key});

  @override
  State<LanguageSelectorSheetWidget> createState() =>
      _LanguageSelectorSheetWidgetState();
}

class _LanguageSelectorSheetWidgetState
    extends State<LanguageSelectorSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 36.0,
            height: 4.0,
            margin: const EdgeInsets.only(bottom: 18.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.language,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 20.0),
          Consumer<LocaleController>(
            builder: (context, value, child) {
              return Column(
                spacing: 4.0,
                children: ['English', 'Español', 'Português'].builder((
                  lang,
                  index,
                ) {
                  return LanguageSelectorSheetOptionWidget(
                    lang: lang,
                    code: AppLocalizations.supportedLocales[index].languageCode,
                    onUpdate: () {
                      setState(() {});
                    },
                  );
                }),
              );
            },
          ),

          const SizedBox(height: 6.0),
        ],
      ),
    );
  }
}
