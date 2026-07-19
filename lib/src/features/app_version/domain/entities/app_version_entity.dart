/// The application's build version, as reported by the platform.
class AppVersionEntity {
  /// Creates a version entity from its [semanticVersion] and [buildNumber].
  const AppVersionEntity({
    required this.semanticVersion,
    required this.buildNumber,
  });

  /// The semantic version string, e.g. `1.2.3`.
  final String semanticVersion;

  /// The platform-specific build number, e.g. `42`.
  final String buildNumber;

  /// Formatted as `semanticVersion+buildNumber` for display.
  String get formatted => '$semanticVersion+$buildNumber';
}
