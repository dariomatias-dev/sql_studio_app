import 'package:flutter/material.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_shadows.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';
import 'package:sql_studio/src/shared/widgets/switch_widget.dart';

/// Toggleable card representing a single SQL suggestion mode, with an
/// optional configure action shown while active.
class SqlSuggestionSettingsCardWidget extends StatelessWidget {
  /// Creates a suggestion mode card.
  const SqlSuggestionSettingsCardWidget({
    required this.title,
    required this.subtitle,
    required this.active,
    required this.onChanged,
    super.key,
    this.onConfigure,
  });

  /// Title of the suggestion mode.
  final String title;

  /// Short description of the suggestion mode.
  final String subtitle;

  /// Whether this suggestion mode is currently enabled.
  final bool active;

  /// Called with the new value when the user toggles this mode.
  final ValueChanged<bool> onChanged;

  /// Called when the user taps the configure button, shown only when
  /// [active] is `true` and this is non-null.
  final VoidCallback? onConfigure;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: () => onChanged(!active),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFFBFBFB) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppShadows.card,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withAlpha(140),
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                SwitchWidget(value: active, onChanged: onChanged),
              ],
            ),
            if (active && onConfigure != null) ...<Widget>[
              const SizedBox(height: 20),
              ButtonWidget(
                onPressed: onConfigure!,
                text: AppLocalizations.of(context)!.configure,
                width: double.infinity,
                height: 42,
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
