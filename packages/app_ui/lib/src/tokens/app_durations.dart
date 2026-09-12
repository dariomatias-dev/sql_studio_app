/// Centralized animation duration scale.
class AppDurations {
  AppDurations._();

  /// Immediate feedback: taps, ripples, small state flips.
  static const xs = Duration(milliseconds: 120);

  /// Default for hovers, toggles and small transitions.
  static const sm = Duration(milliseconds: 200);

  /// Expanding panels, sheets and list reordering.
  static const md = Duration(milliseconds: 250);

  /// Larger surfaces entering or leaving the screen.
  static const lg = Duration(milliseconds: 300);

  /// Deliberately slow feedback, such as a toast lingering.
  static const xl = Duration(milliseconds: 500);

  /// Route transitions.
  static const pageTransition = Duration(milliseconds: 280);

  /// Delay between consecutive items in a staggered entry animation.
  static const stagger = Duration(milliseconds: 40);

  /// Splash screen entry animation.
  static const splash = Duration(milliseconds: 1400);
}
