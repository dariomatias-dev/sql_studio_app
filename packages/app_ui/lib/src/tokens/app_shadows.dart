import 'package:flutter/material.dart';

/// Centralized elevation recipes used across the app.
class AppShadows {
  AppShadows._();

  /// Standard elevated content card (list items, toggle cards, table cards).
  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 6)),
  ];

  /// Stronger elevation for persistent floating chrome (bottom nav bar).
  static const List<BoxShadow> elevated = <BoxShadow>[
    BoxShadow(color: Color(0x26000000), blurRadius: 28, offset: Offset(0, 14)),
  ];

  /// Full-screen overlays: dialogs, bottom sheets.
  static const List<BoxShadow> overlay = <BoxShadow>[
    BoxShadow(color: Color(0x33000000), blurRadius: 40, offset: Offset(0, 20)),
  ];

  /// Small pill/chip elements (suggestion bar chips).
  static const List<BoxShadow> chip = <BoxShadow>[
    BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 1)),
  ];
}
