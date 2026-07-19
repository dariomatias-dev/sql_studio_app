import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_localization_notifier.dart';

class LanguageSelectorSheetOptionWidget extends StatefulWidget {
  final String lang;
  final String code;
  final VoidCallback onUpdate;

  const LanguageSelectorSheetOptionWidget({
    super.key,
    required this.lang,
    required this.code,
    required this.onUpdate,
  });

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

    Fluttertoast.showToast(
      msg: AppLocalizations.of(context)!.languageUpdated(widget.lang),
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0,
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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _changeLanguage,
          borderRadius: BorderRadius.circular(16.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: _isSelected ? Colors.black : const Color(0xFFF8F8F8),
              border: Border.all(
                color: _isSelected ? Colors.black : const Color(0xFFEEEEEE),
                width: 1.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.lang,
                    style: TextStyle(
                      fontSize: 15.0,
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
                    size: 20.0,
                  )
                else
                  Container(
                    height: 20.0,
                    width: 20.0,
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
