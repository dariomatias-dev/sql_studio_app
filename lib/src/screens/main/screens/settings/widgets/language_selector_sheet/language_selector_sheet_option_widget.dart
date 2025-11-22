import 'package:flutter/material.dart';

class LanguageSelectorSheetOptionWidget extends StatefulWidget {
  const LanguageSelectorSheetOptionWidget({
    super.key,
    required this.selectedLanguage,
    required this.lang,
    required this.onUpdate,
  });

  final String selectedLanguage;
  final String lang;
  final VoidCallback onUpdate;

  @override
  State<LanguageSelectorSheetOptionWidget> createState() =>
      _LanguageSelectorSheetOptionWidgetState();
}

class _LanguageSelectorSheetOptionWidgetState
    extends State<LanguageSelectorSheetOptionWidget> {
  late bool isSelected = widget.lang == widget.selectedLanguage;

  @override
  void didUpdateWidget(covariant LanguageSelectorSheetOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    isSelected = widget.lang == widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.0),
        onTap: widget.onUpdate,
        splashColor: Colors.grey.shade400.withAlpha(40),
        highlightColor: Colors.grey.withAlpha(30),
        hoverColor: Colors.grey.withAlpha(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: isSelected ? Colors.blue.withAlpha(22) : Colors.transparent,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.lang,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              AnimatedScale(
                scale: isSelected ? 1.0 : 0.0,
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
