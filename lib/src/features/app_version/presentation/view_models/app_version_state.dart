/// Presentation state for the app version display.
class AppVersionState {
  /// Creates the state, defaulting to a placeholder [formattedVersion].
  const AppVersionState({this.formattedVersion = '-.-.-'});

  /// The version formatted for display, e.g. `1.2.3+42`.
  final String formattedVersion;

  /// Returns a copy of this state with [formattedVersion] replaced.
  AppVersionState copyWith({String? formattedVersion}) {
    return AppVersionState(
      formattedVersion: formattedVersion ?? this.formattedVersion,
    );
  }
}
