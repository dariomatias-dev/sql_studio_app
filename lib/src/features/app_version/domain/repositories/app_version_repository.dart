import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';

/// Reads the current build version from the platform.
typedef GetVersion = Future<Result<AppVersionEntity>> Function();
