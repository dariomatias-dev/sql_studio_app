import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/app_version/data/datasources/app_version_local_datasource.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';

/// Reads the application's build version from the platform.
class AppVersionRepositoryImpl {
  /// Creates the repository with its [_datasource] and [_logger].
  const AppVersionRepositoryImpl(this._datasource, this._logger);

  final AppVersionLocalDatasource _datasource;
  final AppLogger _logger;

  /// Returns the current build version.
  Future<Result<AppVersionEntity>> getVersion() async {
    try {
      final packageInfo = await _datasource.getPackageInfo();

      return SuccessResult(
        AppVersionEntity(
          semanticVersion: packageInfo.version,
          buildNumber: packageInfo.buildNumber,
        ),
      );
    } on Exception catch (err, stackTrace) {
      _logger.error(
        'Failed to get app version',
        error: err,
        stackTrace: stackTrace,
      );

      return const FailureResult(
        AppFailure(AppLocalizationsKey.failedToGetAppVersion),
      );
    }
  }
}
