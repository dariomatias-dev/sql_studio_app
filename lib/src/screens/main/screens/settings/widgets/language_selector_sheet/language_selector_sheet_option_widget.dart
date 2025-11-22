import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/locale_controller.dart';

class LanguageSelectorSheetOptionWidget extends StatefulWidget {
  const LanguageSelectorSheetOptionWidget({
    super.key,
    required this.lang,
    required this.code,
    required this.onUpdate,
  });

  final String lang;
  final String code;
  final VoidCallback onUpdate;

  @override
  State<LanguageSelectorSheetOptionWidget> createState() =>
      _LanguageSelectorSheetOptionWidgetState();
}

class _LanguageSelectorSheetOptionWidgetState
    extends State<LanguageSelectorSheetOptionWidget> {
  late bool _isSelected = _isSelectedLocale;

  bool get _isSelectedLocale =>
      widget.code == context.read<LocaleController>().locale.languageCode;

  Future<void> _changeLanguage() async {
    await context.read<LocaleController>().changeLocale(widget.code);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void didUpdateWidget(covariant LanguageSelectorSheetOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _isSelected = _isSelectedLocale;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _changeLanguage,
        borderRadius: BorderRadius.circular(14.0),
        splashColor: Colors.grey.shade400.withAlpha(40),
        highlightColor: Colors.grey.withAlpha(30),
        hoverColor: Colors.grey.withAlpha(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: _isSelected ? Colors.blue.withAlpha(22) : Colors.transparent,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.lang,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: _isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              AnimatedScale(
                scale: _isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.blue,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
