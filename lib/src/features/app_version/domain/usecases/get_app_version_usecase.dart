import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';
import 'package:sql_studio/src/features/app_version/domain/repositories/app_version_repository.dart';

/// Reads the application's current build version.
class GetAppVersionUseCase {
  /// Creates the use case backed by [_getVersion].
  const GetAppVersionUseCase(this._getVersion);

  final GetVersion _getVersion;

  /// Runs the use case.
  Future<Result<AppVersionEntity>> call() => _getVersion();
}
