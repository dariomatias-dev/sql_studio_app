import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/result.dart';

/// Loads and exposes the current application version.
class AppVersionNotifier extends ChangeNotifier {
  final _logger = Logger();

  String _version = '-.-.-';

  /// The current application version, formatted as `version+buildNumber`.
  String get version => _version;

  /// Loads the application version from the platform's package info.
  Future<Result<void>> load() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _version = '${packageInfo.version}+${packageInfo.buildNumber}';

      notifyListeners();

      return const SuccessResult(null);
    } on Exception catch (err, stackTrace) {
      _logger.e(
        'Failed to get app version',
        error: err,
        stackTrace: stackTrace,
      );

      _version = '-.-.-';

      notifyListeners();

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToGetAppVersion),
      );
    }
  }
}
