import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// Groups related settings entries under a titled section header, each
/// entry rendered directly on the page background and separated from
/// the next by a hairline divider.
class SettingsSectionWidget extends StatelessWidget {
  /// Creates a settings section labeled with [title], wrapping [children].
  const SettingsSectionWidget({
    required this.title,
    required this.children,
    super.key,
  });

  /// Header label for this section.
  final String title;

  /// Settings entries displayed within this section.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, AppSpacing.xl, 0, 10),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: context.colors.textMuted,
              letterSpacing: 0.8,
            ),
          ),
        ),
        for (var i = 0; i < children.length; i++) ...<Widget>[
          if (i > 0)
            Divider(height: 1, thickness: 1, color: context.colors.border),
          children[i],
        ],
      ],
    );
  }
}
