import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

/// A [UrlLauncherPlatform] whose [launchUrl] outcome is fixed at
/// construction, for testing the success and failure paths of code that
/// calls the top-level `launchUrl` without a real platform channel.
class FakeUrlLauncherPlatform extends UrlLauncherPlatform {
  /// Creates a fake platform that resolves [launchUrl] to [shouldLaunch].
  FakeUrlLauncherPlatform({required this.shouldLaunch});

  /// The result every [launchUrl] call resolves to.
  final bool shouldLaunch;

  @override
  LinkDelegate? get linkDelegate => null;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    return shouldLaunch;
  }
}
