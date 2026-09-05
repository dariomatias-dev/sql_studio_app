import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

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
      AppToast.of(
        context,
      ).show(AppLocalizations.of(context)!.languageUpdated(lang)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected =
        code == ref.watch(appLocalizationViewModelProvider).languageCode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: context.colors.transparent,
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
              color: isSelected
                  ? context.colors.black
                  : context.colors.background,
              border: Border.all(
                color: isSelected
                    ? context.colors.black
                    : context.colors.border,
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
                      color: isSelected
                          ? context.colors.white
                          : context.colors.black,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: context.colors.white,
                    size: 20,
                  )
                else
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colors.controlInactive,
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
