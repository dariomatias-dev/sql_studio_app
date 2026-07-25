import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';

/// A single selectable language option shown in the language selector sheet.
class LanguageSelectorSheetOptionWidget extends ConsumerWidget {
  /// Creates a language option for [lang] identified by its locale [code].
  const LanguageSelectorSheetOptionWidget({
    required this.lang,
    required this.code,
    super.key,
  });

  /// Display name of the language shown to the user.
  final String lang;

  /// Locale code associated with this language option.
  final String code;

  Future<void> _changeLanguage(BuildContext context, WidgetRef ref) async {
    await ref
        .read(appLocalizationViewModelProvider.notifier)
        .changeLocale(code);

    if (!context.mounted) return;

    Navigator.pop(context);

    unawaited(
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.languageUpdated(lang),
        backgroundColor: AppColors.black,
        textColor: AppColors.white,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected =
        code == ref.watch(appLocalizationViewModelProvider).languageCode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => _changeLanguage(context, ref),
          borderRadius: BorderRadius.circular(AppRadii.md),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.md),
              color: isSelected ? AppColors.black : AppColors.background,
              border: Border.all(
                color: isSelected ? AppColors.black : AppColors.border,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    lang,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: isSelected ? AppColors.white : AppColors.black,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.white,
                    size: 20,
                  )
                else
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.controlInactive,
                        width: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
