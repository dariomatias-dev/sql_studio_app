import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionNotifier extends ChangeNotifier {
  final _logger = Logger();

  String _version = '...';

  String get version => _version;

  Future<void> load() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _version = '${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (err, stackTrace) {
      _logger.e(
        'Failed to get app version',
        error: err,
        stackTrace: stackTrace,
      );

      _version = 'Unknown';
    }

    notifyListeners();
  }
}
