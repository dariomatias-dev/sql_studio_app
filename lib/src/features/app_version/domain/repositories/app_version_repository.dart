import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';

/// Provides access to the application's build version.
abstract interface class AppVersionRepository {
  /// Reads the current build version from the platform.
  Future<Result<AppVersionEntity>> getVersion();
}
