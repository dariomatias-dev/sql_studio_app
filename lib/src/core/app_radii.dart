/// Centralized corner-radius scale used across the app.
class AppRadii {
  AppRadii._();

  /// Small tags, badges, and popup menus.
  static const double xs = 8;

  /// Icon avatar squares and compact buttons.
  static const double sm = 12;

  /// Default cards, inputs, list items, table nodes.
  static const double md = 16;

  /// Feature-level cards.
  static const double lg = 24;

  /// Modals, dialogs, bottom sheets.
  static const double xl = 32;

  /// Fully-rounded capsule shapes: primary buttons, FAB, nav bar, chips.
  /// A radius larger than half the element's shortest side always yields
  /// a stadium shape regardless of its exact height.
  static const double full = 999;
}
