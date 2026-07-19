import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/switch_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class SqlSuggestionSettingsCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool active;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onConfigure;

  const SqlSuggestionSettingsCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.active,
    required this.onChanged,
    this.onConfigure,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: () => onChanged(!active),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFFBFBFB) : Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(active ? 15 : 8),
              blurRadius: 20.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black.withAlpha(140),
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                SwitchWidget(value: active, onChanged: onChanged),
              ],
            ),
            if (active && onConfigure != null) ...<Widget>[
              const SizedBox(height: 20.0),
              ButtonWidget(
                onPressed: onConfigure!,
                text: AppLocalizations.of(context)!.configure,
                width: double.infinity,
                height: 42.0,
                style: ButtonStyleType.custom,
                backgroundColor: Colors.white,
                borderColor: Colors.black.withAlpha(20),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
