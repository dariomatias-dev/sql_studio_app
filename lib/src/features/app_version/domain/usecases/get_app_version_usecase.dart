import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';
import 'package:sql_studio/src/features/app_version/domain/repositories/app_version_repository.dart';

/// Reads the application's current build version.
class GetAppVersionUseCase {
  /// Creates the use case backed by [_repository].
  const GetAppVersionUseCase(this._repository);

  final AppVersionRepository _repository;

  /// Runs the use case.
  Future<Result<AppVersionEntity>> call() => _repository.getVersion();
}
