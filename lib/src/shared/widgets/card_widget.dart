import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.onTap,
    this.borderRadius,
    required this.child,
  });

  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Widget child;

  BorderRadius get _borderRadius => borderRadius ?? BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: InkWell(borderRadius: _borderRadius, onTap: onTap, child: child),
    );
  }
}
