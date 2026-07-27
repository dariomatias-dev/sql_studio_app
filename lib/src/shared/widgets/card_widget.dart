import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_shadows.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// A rounded, elevated surface that optionally responds to taps.
class CardWidget extends StatelessWidget {
  /// Creates a card wrapping [child].
  const CardWidget({
    required this.child,
    super.key,
    this.onTap,
    this.borderRadius,
    this.border,
  });

  /// Called when the card is tapped. When `null`, the card is inert.
  final VoidCallback? onTap;

  /// Corner radius of the card. Defaults to [AppRadii.md].
  final BorderRadius? borderRadius;

  /// Optional border, e.g. to highlight a selected state.
  final BoxBorder? border;

  /// Content displayed inside the card.
  final Widget child;

  BorderRadius get _borderRadius =>
      borderRadius ?? BorderRadius.circular(AppRadii.md);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: _borderRadius,
        border: border ?? Border.all(color: context.colors.border),
        boxShadow: AppShadows.card,
      ),
      child: InkWell(borderRadius: _borderRadius, onTap: onTap, child: child),
    );
  }
}
