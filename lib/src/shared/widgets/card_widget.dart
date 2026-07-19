import 'package:flutter/material.dart';

/// A rounded, elevated surface that optionally responds to taps.
class CardWidget extends StatelessWidget {
  /// Creates a card wrapping [child].
  const CardWidget({
    required this.child,
    super.key,
    this.onTap,
    this.borderRadius,
  });

  /// Called when the card is tapped. When `null`, the card is inert.
  final VoidCallback? onTap;

  /// Corner radius of the card. Defaults to 12 logical pixels.
  final BorderRadius? borderRadius;

  /// Content displayed inside the card.
  final Widget child;

  BorderRadius get _borderRadius => borderRadius ?? BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(borderRadius: _borderRadius, onTap: onTap, child: child),
    );
  }
}
