import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/switch_widget.dart';

class SqlSuggestionSettingsCardWidget extends StatelessWidget {
  const SqlSuggestionSettingsCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.active,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: () => onChanged(!active),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SwitchWidget(value: active, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
