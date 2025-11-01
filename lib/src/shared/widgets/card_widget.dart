import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, this.onTap, required this.child});

  final VoidCallback? onTap;
  final Widget child;

  BorderRadius get borderRadius => BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: InkWell(borderRadius: borderRadius, onTap: onTap, child: child),
    );
  }
}
