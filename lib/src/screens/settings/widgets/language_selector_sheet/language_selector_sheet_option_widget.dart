import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_localization_notifier.dart';

/// A single selectable language option shown in the language selector sheet.
class LanguageSelectorSheetOptionWidget extends StatefulWidget {
  /// Creates a language option for [lang] identified by its locale [code].
  const LanguageSelectorSheetOptionWidget({
    required this.lang,
    required this.code,
    required this.onUpdate,
    super.key,
  });

  /// Display name of the language shown to the user.
  final String lang;

  /// Locale code associated with this language option.
  final String code;

  /// Called after the locale has been changed.
  final VoidCallback onUpdate;

  @override
  State<LanguageSelectorSheetOptionWidget> createState() =>
      _LanguageSelectorSheetOptionWidgetState();
}

class _LanguageSelectorSheetOptionWidgetState
    extends State<LanguageSelectorSheetOptionWidget> {
  late bool _isSelected = _isSelectedLocale;

  bool get _isSelectedLocale =>
      widget.code ==
      context.read<AppLocalizationNotifier>().locale.languageCode;

  Future<void> _changeLanguage() async {
    await context.read<AppLocalizationNotifier>().changeLocale(widget.code);

    if (!mounted) return;

    Navigator.pop(context);

    unawaited(
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.languageUpdated(widget.lang),
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LanguageSelectorSheetOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = _isSelectedLocale;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _changeLanguage,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _isSelected ? Colors.black : const Color(0xFFF8F8F8),
              border: Border.all(
                color: _isSelected ? Colors.black : const Color(0xFFEEEEEE),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.lang,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: _isSelected
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: _isSelected ? Colors.white : Colors.black,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (_isSelected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 20,
                  )
                else
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD1D1D1),
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
